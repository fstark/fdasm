#pragma once

#include "common.h"
#include "rom.h"
#include <iostream>
#include <string>
#include <vector>

#include <cassert>

class Label;
class Comment;

#include "comment.h"
#include "ioport.h"

#include <unordered_map>

//	Annotations are stuff about the ROM that are managed by the user
//	Annotations are used to create the right disassembly
class Annotations
{
public:
	typedef enum
	{
		kCODE,
		kSTRZ,
		kSTR8S,
		kSTRF2,
		kDATA,
		kDATAW,
		kCOUNT
	} RegionType;

	static const std::string& region_type_name( RegionType type )
	{
		assert( type >= 0 );
		assert( type < kCOUNT );
		static const std::string names[] = { "CODE", "STRZ", "STR8S", "STRF2", "DATA", "DATAW" };
		return names[type];
	}

	Annotations(Rom& rom, const std::string& filename);

	//  Write the annotations in an .fda
	[[nodiscard]] int write_annotations() const;

	//  Label management (#### move to separate class)
	//  Label count
	size_t label_count() const;
	const Label* label_from_adrs(adrs_t adrs) const;
	Label* label_from_adrs(adrs_t adrs);
	const Label* label_before_adrs(adrs_t adrs, int limit) const;
	Label* label_before_adrs(adrs_t adrs, int limit);
	const std::vector<Label>& labels() const { return all_labels_; } // Sorted by adrs
	const std::vector<Label>& labels_by_name() const { return alpha_labels_; } // Sorted by name
	Label* label_from_name(const std::string& name); // unsure if good idea. maybe never let Labels leak and treat only names

	//  Adds a label
	void add_label(const std::string& name, adrs_t adrs, RegionType type, const std::string &comment );

	//  Adds several labels
	void add_labels(const std::vector<Label>& labels);

	//  Removes a label
	void remove_label_if_exists(const std::string& name);

	//	Get the "type" of a given address
	RegionType get_region_type(adrs_t adrs) const;


	//  Comment management

	//  Get a comment
	const Comment* comment_from_adrs(adrs_t adrs) const { return comments_[adrs]; }

	void replace_comment( adrs_t line, const std::string &comment );

	const IOList &io_list() const { return io_list_; }
	IOList &io_list() { return io_list_; }

	void replace_io( uint8_t io_adrs, const std::string &name, const std::string &description );


private:
		//	The list of labels
	std::vector<Label> all_labels_;
	std::vector<Label> alpha_labels_;

		//	The adrs <=> label map (could also be a simpler vector, would help for the label_before_adrs)
	std::unordered_map<adrs_t, Label> labels_map_;

		//	The list of all comments
	std::vector<Comment> all_comments_;

		//	The adrs <=> comments
	std::vector<const Comment*> comments_;

		//	The region of each byte
	std::vector<RegionType> regions_;

		//	The set of IOs
	IOList io_list_;

		//	IOs changed

	void set_region(adrs_t start, adrs_t end, Annotations::RegionType type)
	{
		for (adrs_t adrs = start; adrs <= end; adrs++)
			regions_[adrs - rom_.load_adrs()] = type;
	}

	[[nodiscard]] int read_annotations(const std::string& filename);
	[[nodiscard]] int write_annotations(const std::string& filename) const;

	const Rom& rom_;
	const std::string filename_;

	void labels_changed();
	void comments_changed();
};
