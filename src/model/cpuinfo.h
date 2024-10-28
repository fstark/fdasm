#pragma once

#include "common.h"
#include <string>
#include <vector>

class Instruction
{
	uint8_t opcode_;
	std::string mnemonic_;
	std::string description_;
	std::string flags_;
	std::string effect_;
	bool is_jump_;
	bool is_ref_;

public:
	Instruction(uint8_t opcode, const std::string& mnemonic, const std::string& description, const std::string& flags, const std::string& effect)
	    : opcode_{ opcode }
	    , mnemonic_{ mnemonic }
	    , description_{ description }
	    , flags_{ flags }
	    , effect_{ effect }
	    , is_jump_{ false }
	    , is_ref_{ false }
	{
	}

	Instruction() {}

	uint8_t opcode() const { return opcode_; }
	const std::string& mnemonic() const { return mnemonic_; }
	const std::string& description() const { return description_; }
	const std::string& flags() const { return flags_; }
	const std::string& effect() const { return effect_; }

	bool is_jump() const { return is_jump_; }
	bool is_ref() const { return is_ref_; }

	friend class CPUInfo;
};

class CPUInfo
{
	std::vector<Instruction> instructions_;

	std::vector<Instruction*> jumps_;

public:
	CPUInfo(const std::string filename);
	const Instruction& instruction(uint8_t opcode) const { return instructions_[opcode]; }
	const std::vector<Instruction*>& jumps() const { return jumps_; }
};
