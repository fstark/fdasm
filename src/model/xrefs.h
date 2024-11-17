#pragma once

#include "common.h"

#include <array>
#include <vector>

class Instruction;
class Rom;
class CPUInfo;
class Annotations;

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

struct XRefIO
{
	adrs_t adrs;
	bool is_read;
	uint8_t port;
};


struct XRefIOStats
{
	XRefIOStats() : port(0), reads(0), writes(0) {}

	uint8_t port;
	uint32_t reads;
	uint32_t writes;
};

class XRefs
{

public:
	XRefs(const Rom& rom, const CPUInfo& cpu_info, const Annotations &annotations );

	const std::vector<XRef> xrefs_to(adrs_t adrs) const;

	size_t xrefs_to_count(adrs_t adrs) const;

	const std::vector<XRef>& xrefs() const;

	const std::vector<XRefIO>& get_io_refs() const { return io_references_; }

	const std::vector<XRefIOStats>& get_io_stats() const { return io_stats_; }

private:
	const Rom& rom_;      //  The ROM we cross reference
	const CPUInfo& cpu_info_; //  Information about instructions and their relation to addresses
	const Annotations &annotations_;      //  The annotations helps to identify regions of the ROM

	std::vector<XRef> references_;
	std::vector<XRefIO> io_references_;
	std::vector<XRefIOStats> io_stats_;

	//  True if the address has an instruction
	//  (we do not want data ref from the next byte)
	std::array<bool, 65536> has_instr_;	// #### Unused, can be removed

	//  Create references from a given address
	std::vector<XRef> references_from(adrs_t adrs);
};
