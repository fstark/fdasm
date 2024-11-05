#pragma once

#include "annotations.h"
#include "common.h"
#include "cpuinfo.h"
#include "disassembler.h"
#include "label.h"
#include "rom.h"
#include "xrefs.h"

class Explorer
{
public:
	Explorer(
	    const std::string& cpuinfo,
	    const std::string& Rom,
		adrs_t load_adrs,
	    const std::string& fdafile)
	    : cpu_info_{ cpuinfo }
	    , rom_contents_{ Rom, load_adrs }
	    , annotations_{ rom_contents_, fdafile }
	    , disassembler_{ rom_contents_, annotations_ }
	    , xrefs_{ rom_contents_, cpu_info_, annotations_ }
	{
		if (annotations_.label_count() == 0)
		{
			//  Generates all the labels from xrefs
			std::vector<bool> code;
			// code.resize(rom_contents_.size());
			code.resize( 65536 );
			std::vector<bool> data;
			// data.resize(rom_contents_.size());
			data.resize( 65536);
			for (const auto& xref : xrefs_.xrefs())
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
			for (adrs_t adrs = rom_contents_.load_adrs(); adrs <= rom_contents_.last_adrs(); adrs++)
			{
				if (code[adrs])
				{
					char buffer[16];
					snprintf(buffer, sizeof(buffer), "L%04X", adrs);
					Label label(adrs, buffer, Annotations::kCODE);
					labels.push_back(label);
				}
				else if (adrs > 256 && data[adrs])
				{
					char buffer[16];
					snprintf(buffer, sizeof(buffer), "D%04X", adrs);
					Label label(adrs, buffer, Annotations::kDATA);
					labels.push_back(label);
				}
			}

			std::clog << "Labels: " << labels.size() << std::endl;

			annotations_.add_labels(labels);

			//	If we don't have a label for LOAD, we add one
			if (!annotations_.label_from_adrs(rom_contents_.load_adrs()))
			{
				annotations_.add_label("LOAD", rom_contents_.load_adrs(), Annotations::kCODE, "Load address");
			}
		}
	}

	// #### Nope
	Disassembler* disassembler() { return &disassembler_; }

	const Rom& rom() const { return rom_contents_; }
	const CPUInfo& cpu_info() const { return cpu_info_; }
	const XRefs& xrefs() const { return xrefs_; }
	Annotations& annotations() { return annotations_; }

private:
	CPUInfo cpu_info_;
	Rom rom_contents_;
	Annotations annotations_;
	Disassembler disassembler_;
	XRefs xrefs_;


};
