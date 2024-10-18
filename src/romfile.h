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

    adrs_t load_adrs() const { return load_adrs_; }
    uint8_t get(adrs_t adrs) const { return bytes_[adrs]; }
    uint16_t get_word(adrs_t adrs) const { return bytes_[adrs] + (bytes_[adrs+1] << 8); }
    uint16_t size() const { return bytes_.size(); }

    bool contains(adrs_t adrs) const { return adrs >= load_adrs_ && (int)(adrs)-load_adrs_ < bytes_.size(); }
};
