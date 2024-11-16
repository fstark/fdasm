#include "xrefs.h"

#include "annotations.h"
#include "cpuinfo.h"
#include "rom.h"

#include <algorithm>

XRefs::XRefs(const Rom& rom, const CPUInfo& cpu_info, const Annotations &annotations )
    : rom_{ rom }
    , cpu_info_{ cpu_info }
    , annotations_{ annotations }
// annotations_{ annotations }
{

    std::array<XRefIOStats, 256> io_stats;
    //  Init port numbers
    for (int i = 0; i < 256; i++)
    {
        io_stats[i].port = i;
    }

    for (adrs_t adrs = rom.load_adrs(); adrs <= rom.last_adrs(); adrs++)
    {
        auto refs = references_from(adrs);
        for (const auto& ref : refs)
        {
            references_.push_back(ref);
        }

        //  Look if instruction is a read or write to an I/O port
        if (rom.contains(adrs + 1))
        {
            auto& i = cpu_info_.instruction(rom.get(adrs));
            if (i.is_io_read() || i.is_io_write())
            {
                XRefIO ref;
                ref.adrs = adrs;
                ref.is_read = i.is_io_read();
                ref.port = rom.get(adrs + 1);
                io_references_.push_back(ref);

                if (ref.is_read)
                {
                    io_stats[ref.port].reads++;
                }
                else
                {
                    io_stats[ref.port].writes++;
                }
            }
        }      
    }

    //  Builds io_stats_
    for (int i = 0; i < 256; i++)
    {
        if (io_stats[i].reads || io_stats[i].writes)
            io_stats_.push_back(io_stats[i]);
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
