#include "annotations.h"
#include "label.h"
#include "utils.h"

#include <algorithm>
#include <cassert>
#include <map>
#include <stdio.h>
#include <string>
#include <unordered_map>
#include <cstring>

Annotations::Annotations(Rom& rom, const std::string& filename)
    : rom_{ rom }
    , filename_{ filename }
{
	regions_.resize(rom_.size());
	comments_.resize(65536);

	set_region(rom.load_adrs(), rom_.last_adrs(), kCODE);
	if (read_annotations(filename_)==-1)
	{
		fprintf( stderr, "Failed to read regions file: %s\n", filename_.c_str());
		throw std::runtime_error("Failed to read regions file");
	}
}

int Annotations::read_annotations(const std::string& filename)
{
	FILE* file = fopen(filename.c_str(), "r");

	//	We failed to open, let's try to create an empty file
	if (file == NULL)
	{
		// Create the file if it does not exist
		file = fopen(filename.c_str(), "w");
		if (file == NULL)
		{
			fprintf(stderr, "Failed to create file: %s\n", filename.c_str());
			return -1;
		}
		fclose(file);
		// Reopen the file in read mode
		file = fopen(filename.c_str(), "r");
	}

	if (file == NULL)
	{
		fprintf(stderr, "Failed to open file: %s\n", filename.c_str());
		return -1;
	}

	io_list_ = {};

	char line[256];
	while (fgets(line, sizeof(line), file))
	{
		unsigned int adrs;
		char type[16];
		char name[16];
		char comment[16384];
		if (sscanf(line, "LABEL %04XH %s %s", &adrs, type, name )==3)
		{
			Annotations::RegionType RegionType = Annotations::kCODE;
			if (strcmp(type, "CODE") == 0)
				RegionType = Annotations::kCODE;
			else if (strcmp(type, "STRZ") == 0)
				RegionType = Annotations::kSTRZ;
			else if (strcmp(type, "DATAW") == 0)
				RegionType = Annotations::kDATAW;
			else if (strcmp(type, "STR8S") == 0)
				RegionType = Annotations::kSTR8S;
			else if (strcmp(type, "DATA") == 0)
				RegionType = Annotations::kDATA;
			else if (strcmp(type, "STRF2") == 0)
				RegionType = Annotations::kSTRF2;

			all_labels_.push_back({ static_cast<adrs_t>(adrs), name, RegionType });
		}

		if (sscanf(line, "COMMENT LABEL %s \"%[^\"]\"", name, comment )==2)
		{
			//	Find the last 
			if (all_labels_.size()>0)
			{
				if (all_labels_.back().name()==name)
					all_labels_.back().set_comment(unescape(comment));
				else
					for (Label l:all_labels_)
						if (l.name()==name)
						{
							l.set_comment( unescape(comment) );
							break;
						}
			}
		}

		if (sscanf(line, "IO %02XH %s \"%[^\"]\"", &adrs, name, comment )==3)
		{
			auto &port = io_list_.get_port( adrs );
			port.set_name( name );
			port.set_comment( unescape(comment) );
		}

		if (sscanf(line, "COMMENT LINE %04XH \"%[^\"]\"", &adrs, comment )==2)
		{
			all_comments_.emplace_back( adrs, unescape(comment), true );
			continue;
		}
	}

	fclose(file);

	comments_changed();
	labels_changed();
	// ios_changed();

	return 0;
}

int Annotations::write_annotations(const std::string& filename) const
{
	FILE* file = fopen(filename.c_str(), "w");
	if (file == NULL)
	{
		fprintf( stderr, "Failed to open file: %s\n", filename.c_str());
		return -1;
	}

	for (const auto& label : all_labels_)
	{
		std::string type = "UNKNOWN";
		switch (label.type())
		{
			case kCODE: type = "CODE"; break;
			case kSTRZ: type = "STRZ"; break;
			case kDATAW: type = "DATAW"; break;
			case kSTR8S: type = "STR8S"; break;
			case kDATA: type = "DATA"; break;
			case kSTRF2: type = "STRF2"; break;
			case kCOUNT: type = "ERROR"; break;
		}
		fprintf(file, "LABEL %04XH %s %s\n", label.start_adrs(), type.c_str(), label.name().c_str());
		if (!label.comment().empty())
			fprintf(file, "COMMENT LABEL %s \"%s\"\n", label.name().c_str(), escape(label.comment()).c_str());
	}

	//	Write the comments
	for (const auto& comment : all_comments_)
	{
		fprintf(file, "COMMENT LINE %04XH \"%s\"\n", comment.adrs(), escape(comment.comment_text().text()).c_str());
	}

	//	Write the I/O ports
	for (int ix=0;ix!=256;ix++)
	{
		auto &port = io_list().get_port(ix);
		//	Only write if there is a name or a comment
		if (!port.name().empty() || !port.full_comments().empty())
			fprintf(file, "IO %02XH %s \"%s\"\n",
				ix,
				port.name().c_str(),
				escape(port.full_comments()).c_str()
			);
	}

	fclose(file);

	return 0;
}

int Annotations::write_annotations() const
{
	std::clog << "Writing annotations to " << filename_ << std::endl;
	return write_annotations(filename_);
}

void Annotations::labels_changed()
{
	// Sorts the labels by address
	std::sort(all_labels_.begin(), all_labels_.end(), [](const Label& a, const Label& b)
	    { return a.start_adrs() < b.start_adrs(); });
	    // { return a.name() < b.name(); });

	alpha_labels_ = all_labels_;
	std::sort(alpha_labels_.begin(), alpha_labels_.end(), [](const Label& a, const Label& b)
	    { return a.name() < b.name(); });

	labels_map_.clear();
	for (const auto& label : all_labels_)
	{
		labels_map_.emplace(label.start_adrs(), label);
	}

	//  Sets the end address of each label
	for (size_t i = 0; i + 1 < all_labels_.size(); i++)
	{
		all_labels_[i].set_end_adrs(all_labels_[i + 1].start_adrs() - 1);
	}

	if (!all_labels_.empty())
		all_labels_.back().set_end_adrs(rom_.last_adrs());
}

void Annotations::replace_comment( adrs_t line, const std::string &comment )
{
	//	Remove the existing comment
	for (auto it = all_comments_.begin(); it != all_comments_.end(); ++it)
	{
		if (it->adrs() == line)
		{
			all_comments_.erase(it);
			break;
		}
	}

	//	Add the new comment
	if (!comment.empty())
		all_comments_.emplace_back( line, comment, true );

	comments_changed();
}

void Annotations::comments_changed()
{
	//	Clear the comments_ vector
	comments_.clear();
	comments_.resize(65536);

	//	Repopulate the comments_ vector
	for (const auto& comment : all_comments_)
	{
		comments_[comment.adrs()] = &comment;
	}
}

void Annotations::replace_io( uint8_t io_adrs, const std::string &name, const std::string &description )
{
	auto &port = io_list_.get_port( io_adrs );
	port.set_name( name );
	port.set_comment( description );

	// ios_changed();
}


size_t Annotations::label_count() const { return all_labels_.size(); }

void Annotations::add_label(const std::string& name, adrs_t adrs, RegionType type, const std::string& comment)
{
	Label label(adrs, name, type, comment);
	all_labels_.push_back(label);
	labels_changed();
}

void Annotations::add_labels(const std::vector<Label>& labels)
{
	all_labels_.insert(all_labels_.end(), labels.begin(), labels.end());
	labels_changed();
}

void Annotations::remove_label_if_exists(const std::string& name)
{
	auto it = std::remove_if(all_labels_.begin(), all_labels_.end(), [&name](const Label& label)
	    { return label.name() == name; });
	if (it != all_labels_.end())
	{
		all_labels_.erase(it, all_labels_.end());
		labels_changed();
	}
}

Annotations::RegionType Annotations::get_region_type(adrs_t adrs) const
{
	// Find in the all_labels_ sorted array
	// the last one that is less than adrs

	for (auto it = all_labels_.rbegin(); it != all_labels_.rend(); it++)
	{
		if (it->start_adrs() <= adrs)
			return it->type();
	}

	return kCODE;
}

// #### Beurk
Label* Annotations::label_from_adrs(adrs_t adrs)
{
	auto it = labels_map_.find(adrs);
	if (it != labels_map_.end())
		return &it->second;
	return nullptr;
}

const Label* Annotations::label_from_adrs(adrs_t adrs) const
{
	auto it = labels_map_.find(adrs);
	if (it != labels_map_.end())
		return &it->second;
	return nullptr;
}

const Label* Annotations::label_before_adrs(adrs_t adrs, int limit) const
{
	// #### Must use a find!
	for (auto it = all_labels_.rbegin(); it != all_labels_.rend(); it++)
	{
		if (it->start_adrs() <= adrs)
		{
			if (adrs - it->start_adrs() <= limit)
				return &(*it);
			else
				return nullptr;
		}
	}

	return nullptr;
}

Label* Annotations::label_before_adrs(adrs_t adrs, int limit)
{
	// #### Must use a find!
	for (auto it = all_labels_.rbegin(); it != all_labels_.rend(); it++)
	{
		if (it->start_adrs() <= adrs)
		{
			if (adrs - it->start_adrs() <= limit)
				return &(*it);
			else
				return nullptr;
		}
	}

	return nullptr;
}

Label* Annotations::label_from_name(const std::string& name)
{
	for (auto& label : all_labels_)
	{
		if (label.name() == name)
			return &label;
	}
	return nullptr;
}
