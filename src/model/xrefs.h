#pragma once

#include "annotations.h"
#include "cpuinfo.h"
#include "common.h"
#include "romfile.h"
#include <array>

struct XRef
{
public:
	typedef enum
	{
		kJUMP, //  Some sort of transfer of execution
		kREF,  //  A reference to a memory location
		kDATA  //  The address appears as data
	} Type;

	adrs_t from_; //  Where the reference is from. For kJUMP and kREF this is the address of the instruction
	adrs_t to_;   //  The referenced address

	Type type_; //  The type of reference

	bool is_local; //  The reference is in the same region
	bool from_data; //  The reference is from data section (for JUMP or REF it means they are less likely to be interesting)

	const Instruction* instruction; //  The instruction that references this address
};

class XRefs
{

public:
	XRefs(const ROMFile& rom, const CPUInfo& cpu_info, const Annotations &annotations )
	    : rom_{ rom }
	    , cpu_info_{ cpu_info }
		, annotations_{ annotations }
	// annotations_{ annotations }
	{
		for (adrs_t adrs = 0; adrs < rom.size(); adrs++)
		{
			auto refs = references_from(adrs);
			for (const auto& ref : refs)
			{
				references_.push_back(ref);
			}
		}
	}

	const std::vector<XRef> xrefs_to(adrs_t adrs) const
	{
		std::vector<XRef> result;
		for (const auto& ref : references_)
		{
			if (ref.to_ == adrs)
				result.push_back(ref);
		}
		return result;
	}

	const std::vector<XRef>& xrefs() const
	{
		return references_;
	}

private:
	const ROMFile& rom_;      //  The ROM we cross reference
	const CPUInfo& cpu_info_; //  Information about instructions and their relation to addresses
	const Annotations &annotations_;      //  The annotations helps to identify regions of the ROM

	std::vector<XRef> references_;

	//  True if the address has an instruction
	//  (we do not want data ref from the next byte)
	std::array<bool, 65536> has_instr_;

	//  Create references from a given address
	std::vector<XRef> references_from(adrs_t adrs)
	{
		std::vector<XRef> result;
		bool from_data = annotations_.get_region_type(adrs)!=Annotations::kCODE;
		//  We may be jumping to somewhere
		auto& i = cpu_info_.instruction(rom_.get(adrs));
		//  Jmp or Call
		if (i.is_jump() && rom_.contains(adrs + 2))
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
		if (i.is_ref() && rom_.contains(adrs + 2))
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
		if (adrs >= 1 && !has_instr_[adrs - 1] && rom_.contains(adrs + 1))
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
};
