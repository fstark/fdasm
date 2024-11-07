#pragma once

#include "common.h"
#include <string>
#include <vector>

class Instruction
{
public:
	Instruction(uint8_t opcode, const std::string& mnemonic, const std::string& description, const std::string& flags, const std::string& effect);

	Instruction() {}

	uint8_t opcode() const { return opcode_; }
	const std::string& mnemonic() const { return mnemonic_; }
	const std::string& short_mnemonic() const { return short_mnemonic_; }
	const std::string& description() const { return description_; }
	const std::string& flags() const { return flags_; }
	const std::string& effect() const { return effect_; }

	bool is_jump() const { return is_jump_; }
	bool is_ref() const { return is_ref_; }

	bool has_d8() const { return has_d8_; }
	bool has_d16() const { return has_d16_; }
	bool has_adrs() const { return has_adrs_; }

	friend class CPUInfo;

private:
	uint8_t opcode_;
	std::string mnemonic_;
	std::string short_mnemonic_;
	std::string description_;
	std::string flags_;
	std::string effect_;
	bool is_jump_;
	bool is_ref_;

	bool has_d8_ = false;
	bool has_d16_ = false;
	bool has_adrs_ = false;
};

class CPUInfo
{
public:
	CPUInfo(const std::string filename);
	const Instruction& instruction(uint8_t opcode) const { return instructions_[opcode]; }
	const std::vector<Instruction*>& jumps() const { return jumps_; }

private:
	std::vector<Instruction> instructions_;
	std::vector<Instruction*> jumps_;
};
