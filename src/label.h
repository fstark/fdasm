#pragma once

#include "common.h"
#include "annotations.h"
#include <vector>

class Label
{
    adrs_t start_adrs_;
    adrs_t end_adrs_;       //  Automatically set by Annotations::labels_changed()
    std::string name_;
    Annotations::RegionType type_;

    void set_end_adrs(adrs_t end_adrs) { end_adrs_ = end_adrs; }

public:
    Label(adrs_t start_adrs, const std::string &name, Annotations::RegionType type) :
        start_adrs_{ start_adrs },
        end_adrs_{ start_adrs },
        name_{ name },
        type_{ type }
    {
    }

    adrs_t start_adrs() const { return start_adrs_; }
    adrs_t end_adrs() const { return end_adrs_; }
    Annotations::RegionType type() const { return type_; }
    const std::string &name() const { return name_; }

    friend class Annotations;
};
