#pragma once

#include "common.h"
#include <vector>

class ROMFile
{
    std::vector<uint8_t> bytes_;
    adrs_t load_adrs_ = 0;
public:
    ROMFile( const std::string &rom_file, adrs_t load_adrs );
    const std::vector<uint8_t> &bytes() const { return bytes_; }

    uint8_t get(adrs_t adrs) const { return bytes_[adrs]; }
};
