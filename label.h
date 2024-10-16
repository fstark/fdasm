#pragma once

#include "common.h"
#include "region.h"
#include <vector>

class Label
{
    adrs_t start_adrs_;
    adrs_t end_adrs_;
    std::string name_;
    RomContents::RegionType type_;

public:
    Label(adrs_t start_adrs, adrs_t end_adrs, const std::string &name, RomContents::RegionType type) :
        start_adrs_{ start_adrs },
        end_adrs_{ end_adrs },
        name_{ name },
        type_{ type }
    {
    }

    adrs_t start_adrs() const { return start_adrs_; }
    adrs_t end_adrs() const { return end_adrs_; }
    RomContents::RegionType type() const { return type_; }
    const std::string &name() const { return name_; }

    void set_end_adrs(adrs_t end_adrs) { end_adrs_ = end_adrs; }
};
