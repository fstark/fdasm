#pragma once

#include "common.h"
#include "rom.h"
#include <iostream>
#include <string>
#include <vector>

class Label;

class Annotations
{
public:
	typedef enum
	{
		kUNKNOWN,
		kCODE,
		kSTRZ,
		kSTR8S,
		kSTRF2,
		kDATA,
		kDATAW,
		kCOUNT
	} RegionType;

	Annotations(Rom& rom, const std::string& filename);

	RegionType get_region_type(adrs_t adrs) const;

	static Label* label_from_adrs(adrs_t adrs);
	static Label* label_before_adrs(adrs_t adrs, int limit);
	static const std::vector<Label>& get_labels();
	static Label* label_from_name(const std::string& name); // unsure if good idea. maybe never let Labels leak and treat only names

	//  Adds a label
	void add_label(const std::string& name, adrs_t adrs, RegionType type);

	//  Adds several labels
	void add_labels(const std::vector<Label>& labels);

	//  Removes a label
	void remove_label_if_exists(const std::string& name);

	//  Write the region file
	[[nodiscard]] int write_regions() const;

	//  Label count
	size_t label_count() const;

private:
	std::vector<RegionType> regions_;

	void set_region(adrs_t start, adrs_t end, Annotations::RegionType type)
	{
		std::clog << "Setting region " << start << " to " << end << " to " << type << std::endl;
		for (adrs_t adrs = start; adrs <= end; adrs++)
			regions_[adrs - rom_.load_adrs()] = type;
	}

	[[nodiscard]] int read_regions(const std::string& filename);
	[[nodiscard]] int write_regions(const std::string& filename) const;

	const Rom& rom_;
	const std::string filename_;

	void labels_changed();
};
