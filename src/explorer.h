#pragma once

#include "common.h"
#include "cpuinfo.h"
#include "annotations.h"
#include "romfile.h"
#include "disassembler.h"
#include "xrefs.h"
#include "label.h"

class Explorer
{
    CPUInfo cpu_info_;
    ROMFile rom_contents_;
    Annotations annotations_;
    Disassembler disassembler_;
    XRefs xrefs_;

public:
    Explorer(
        const std::string &cpuinfo,
        const std::string &romfile,
        const std::string &fdafile
        ) :
            cpu_info_{ cpuinfo },
            rom_contents_{ romfile, 0 },
            annotations_{ rom_contents_, fdafile },
            disassembler_{ rom_contents_.bytes(), 0, std::make_shared<Annotations>(annotations_) },
            xrefs_{ rom_contents_, cpu_info_, annotations_ }
    {
        //  Generates all the labels from xrefs
        std::vector<bool> code;
        code.resize(rom_contents_.size());
        std::vector<bool> data;
        data.resize(rom_contents_.size());
        for (const auto &xref: xrefs_.xrefs())
        {   
            if (rom_contents_.contains(xref.to_))
            {
                if (xref.type_ == XRef::kJUMP)
                    code[xref.to_] = true;
                if (xref.type_ == XRef::kREF)
                    data[xref.to_] = true;
            }
        }

        std::vector<Label> labels;
        for (adrs_t adrs = 0; adrs < rom_contents_.size(); adrs++)
        {
            if (code[adrs])
            {
                char buffer[16];
                snprintf( buffer, sizeof(buffer), "L%04X", adrs );   
                Label label( adrs, buffer, Annotations::kCODE );
                labels.push_back( label );
            }
            else if (adrs>256 && data[adrs])
            {
                char buffer[16];
                snprintf( buffer, sizeof(buffer), "D%04X", adrs );   
                Label label( adrs, buffer, Annotations::kDATA );
                labels.push_back( label );
            }
        }

        std::clog << "Labels: " << labels.size() << std::endl;

        annotations_.add_labels( labels );
    }

    // #### Nope
    Disassembler *disassembler() { return &disassembler_; }

    const ROMFile &rom() const { return rom_contents_; }
    const CPUInfo &cpu_info() const { return cpu_info_; }
    const XRefs &xrefs() const { return xrefs_; }
};
