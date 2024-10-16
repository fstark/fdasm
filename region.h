#pragma once

#include "common.h"
#include <vector>
#include <iostream>

class Label;

class RomContents
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

    RomContents( const char *filename );
    ~RomContents()
    {
        std::clog << "Deleting Rom Contents" << std::endl;
    }

    adrs_t start_;
    adrs_t end_;

	RegionType get_region_type(adrs_t adrs);
    Label *label_from_adrs(adrs_t adrs);

    static const std::vector<Label> &get_labels();

private:
    std::vector<RegionType> regions_;

    void set_region( adrs_t start, adrs_t end, RomContents::RegionType type )
    {
        std::clog << "Setting region " << start << " to " << end << " to " << type << std::endl;
        for (adrs_t adrs = start; adrs <= end; adrs++)
            regions_[adrs-start_] = type;
    }

    void read_regions( const char * filename );
};
