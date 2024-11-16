#include "cpuinfo.h"

#include <iostream>
#include <stdio.h>

#include <cstring>

Instruction::Instruction(uint8_t opcode, const std::string& mnemonic, const std::string& description, const std::string& flags, const std::string& effect)
	: opcode_{ opcode }
	, mnemonic_{ mnemonic }
	, description_{ description }
	, flags_{ flags }
	, effect_{ effect }
	, is_jump_{ false }
	, is_ref_{ false }
{
	std::string short_mnemonic = mnemonic;

	//	Remove "D8" from the mnemonic
	size_t pos = short_mnemonic.find("D8");
	if (pos != std::string::npos)
	{
		short_mnemonic.erase(pos, 2);
		has_d8_ = true;
	}

	//	Remove "D16" from the mnemonic
	pos = short_mnemonic.find("D16");
	if (pos != std::string::npos)
	{	
		short_mnemonic.erase(pos, 3);
		has_d16_ = true;
	}
	//	Remove "adr" from the mnemonic
	pos = short_mnemonic.find("adr");
	if (pos != std::string::npos)
	{
		short_mnemonic.erase(pos, 3);
		has_adrs_ = true;
	}

	short_mnemonic_ = short_mnemonic;

	shorter_mnemonic_ = short_mnemonic;

	//	Remove "," from the shorter_mnemonic
	pos = shorter_mnemonic_.find(",");
	if (pos != std::string::npos)
	{
		shorter_mnemonic_.erase(pos, 1);
	}
	//	Remove " " at the end of the shorter_mnemonic if any
	if (shorter_mnemonic_.back() == ' ')
	{
		shorter_mnemonic_.pop_back();
	}
}

CPUInfo::CPUInfo(const std::string filename)
{
	instructions_.resize(256);

	// Read the file and populate the instruction set
	FILE* file = fopen(filename.c_str(), "r");
	if (file == NULL)
	{
		std::cerr << "Failed to open file: " << filename << std::endl;
		throw std::runtime_error("Failed to open CPU definition file");
		return;
	}

	std::vector<std::string> lines;

	char line[256];
	while (fgets(line, sizeof(line), file))
	{
		if (line[0] == ';' || line[0] == '#')
			continue;
		// Remove the newline
		char* nl = strchr(line, '\n');
		if (nl)
			*nl = 0;
		// Skip leading spaces
		char* p = line;
		while (*p == ' ')
			++p;
		lines.push_back(p);
	}

	fclose(file);

	// Parse the lines
	auto l = lines.begin();
	while (l != lines.end())
	{
		// Parse the line
		// 06: MVI B, D8
		//     Move immediate 8-bit data to register B
		//     Flags affected: None
		//     B <- byte 2
		// Split the line into tokens

		if (l->empty())
		{
			++l;
			continue;
		}

		// Opcode are the first 2 chars
		// std::clog << "[" << l->substr(0, 2) << "] " << *l << std::endl;
		uint8_t opcode = std::stoi(l->substr(0, 2), nullptr, 16);
		// Opcode is the rest of the line
		std::string mnemonic = l->substr(4);

		//  Read description, flags and effect
		std::string description = *++l;
		std::string flags       = *++l;

		// If the next line is not empty, it is the effect
		std::string effect;
		if (++l != lines.end() && !l->empty())
		{
			effect = *l;
			++l;
		}

		Instruction i(opcode, mnemonic, description, flags, effect);
		instructions_[opcode] = i;
	}

	//  Mark the jumps, call & conditional jumps

	instructions_[0xc2].is_jump_ = true; //  JNZ
	instructions_[0xc3].is_jump_ = true; //  JMP
	instructions_[0xc4].is_jump_ = true; //  CNZ
	instructions_[0xca].is_jump_ = true; //  JZ
	instructions_[0xcc].is_jump_ = true; //  CZ
	instructions_[0xcd].is_jump_ = true; //  CALL

	instructions_[0xd2].is_jump_ = true; //  JNC
	instructions_[0xd4].is_jump_ = true; //  CNC
	instructions_[0xda].is_jump_ = true; //  JC
	instructions_[0xdc].is_jump_ = true; //  CC

	instructions_[0xe2].is_jump_ = true; //  JPO
	instructions_[0xe4].is_jump_ = true; //  CPO
	instructions_[0xea].is_jump_ = true; //  JPE
	instructions_[0xec].is_jump_ = true; //  CPE

	instructions_[0xf2].is_jump_ = true; //  JP
	instructions_[0xf4].is_jump_ = true; //  CP
	instructions_[0xfa].is_jump_ = true; //  JM
	instructions_[0xfc].is_jump_ = true; //  CM

	//  Instructions that reference an address

	instructions_[0x01].is_ref_ = true; //  LXI
	instructions_[0x11].is_ref_ = true; //  LXI
	instructions_[0x21].is_ref_ = true; //  LXI
	instructions_[0x22].is_ref_ = true; //  SHLD
	instructions_[0x2a].is_ref_ = true; //  LHLD
	instructions_[0x31].is_ref_ = true; //  LXI
	instructions_[0x32].is_ref_ = true; //  STA
	instructions_[0x3a].is_ref_ = true; //  LDA
}
