#pragma once

#include "common.h"
#include <vector>
#include <string>

class Instruction
{
    uint8_t opcode_;
    std::string mnemonic_;
    std::string description_;
    std::string flags_;
    std::string effect_;
public:
    Instruction( uint8_t opcode, const std::string &mnemonic, const std::string &description, const std::string &flags, const std::string &effect ) :
        opcode_{ opcode },
        mnemonic_{ mnemonic },
        description_{ description },
        flags_{ flags },
        effect_{ effect }
    {
    }

    Instruction() {}

    uint8_t opcode() const { return opcode_; }
    const std::string &mnemonic() const { return mnemonic_; }
    const std::string &description() const { return description_; }
    const std::string &flags() const { return flags_; }
    const std::string &effect() const { return effect_; }
};

class CPUInfo
{
    std::vector<Instruction> instructions_;

public:
    CPUInfo( const std::string filename );
    const Instruction &instruction( uint8_t opcode ) const { return instructions_[opcode]; }    
};
