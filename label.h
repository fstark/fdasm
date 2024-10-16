#include "common.h"
#include "region.h"
#include <vector.h>

class Label
{
    adrs_t adrs_;
    std::string name_;
    RomContents::RegionType type;

public:
    Label( adrs_t adrs, const std::string &name, RomContents::RegionType type ) :
        adrs_{ adrs },
        name_{ name },
        type{ type }
    {
    }

    static std::vector<Label> labels() const
    {
        static std::vector<Label> labels;
        labels.push_back( Label{ 0x0000, "RESET", RomContents::RegionType::kCODE } );
        labels.push_back( Label{ 0x7d33, "COLDBOOT", RomContents::RegionType::kCODE } );
        return labels;
    };
};
