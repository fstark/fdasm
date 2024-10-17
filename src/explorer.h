#pragma once

#include "common.h"
#include "cpuinfo.h"
#include "annotations.h"
#include "romfile.h"
#include "disassembler.h"

class Explorer
{
    CPUInfo cpu_info_;
    ROMFile rom_contents_;
    Annotations annotations_;
    Disassembler disassembler_;

public:
    Explorer(
        const std::string &cpuinfo,
        const std::string &romfile,
        const std::string &fdafile
        ) :
            cpu_info_{ cpuinfo },
            rom_contents_{ romfile, 0 },
            annotations_{ fdafile },
            disassembler_{ rom_contents_.bytes(), 0, std::make_shared<Annotations>(annotations_) }
    {
    }

    // #### Nope
    Disassembler *disassembler() { return &disassembler_; }

    const ROMFile &rom() const { return rom_contents_; }
    const CPUInfo &cpu_info() const { return cpu_info_; }
};
