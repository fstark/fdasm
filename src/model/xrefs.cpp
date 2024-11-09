#include "xrefs.h"

#include "annotations.h"
#include "cpuinfo.h"
#include "rom.h"

XRefs::XRefs(const Rom& rom, const CPUInfo& cpu_info, const Annotations &annotations )
    : rom_{ rom }
    , cpu_info_{ cpu_info }
    , annotations_{ annotations }
// annotations_{ annotations }
{
    for (adrs_t adrs = rom.load_adrs(); adrs <= rom.last_adrs(); adrs++)
    {
        auto refs = references_from(adrs);
        for (const auto& ref : refs)
        {
            references_.push_back(ref);
        }
    }
}

const std::vector<XRef> XRefs::xrefs_to(adrs_t adrs) const
{
    std::vector<XRef> result;
    for (const auto& ref : references_)
    {
        if (ref.to_ == adrs)
            result.push_back(ref);
    }
    return result;
}

const std::vector<XRef>& XRefs::xrefs() const
{
    return references_;
}

std::vector<XRef> XRefs::references_from(adrs_t adrs)
{
    std::vector<XRef> result;
    auto region_type = annotations_.get_region_type(adrs);
    bool from_data = region_type!=Annotations::kCODE;
    //  We may be jumping to somewhere
    auto& i = cpu_info_.instruction(rom_.get(adrs));
    //  Jmp or Call
    if (!from_data && i.is_jump() && rom_.contains(adrs + 2))
    {
        XRef ref;
        ref.from_ = adrs;
        ref.to_   = rom_.get_word(adrs + 1);
        ref.type_ = XRef::kJUMP;
        //            ref.is_local = annotations_.get_region_type(adrs) == annotations_.get_region_type(ref.to_);
        ref.instruction = &i;
        ref.from_data = from_data;
        result.push_back(ref);
        has_instr_[adrs] = true;
    }
    //  We may be loading an address
    if (!from_data && i.is_ref() && rom_.contains(adrs + 2))
    {
        XRef ref;
        ref.from_ = adrs;
        ref.to_   = rom_.get_word(adrs + 1);
        ref.type_ = XRef::kREF;
        //            ref.is_local = annotations_.get_region_type(adrs) == annotations_.get_region_type(ref.to_);
        ref.instruction = &i;
        ref.from_data = from_data;
        result.push_back(ref);
        has_instr_[adrs] = true;
    }
    //  Just a reference
    if (from_data && adrs >= 1 /* && !has_instr_[adrs - 1] */ && rom_.contains(adrs + 1))
    {
        XRef ref;
        ref.from_       = adrs;
        ref.to_         = rom_.get_word(adrs);
        ref.type_       = XRef::kDATA;
        ref.instruction = nullptr;
        ref.from_data = from_data;
        result.push_back(ref);
    }
    return result;
}
