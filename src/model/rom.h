#pragma once

#include "common.h"
#include <vector>

#include <string>

#include <stdexcept>

//	A ROM file loaded into memory
class Rom
{
public:
	Rom(const std::string& rom_file, adrs_t load_adrs);
	const std::vector<uint8_t>& bytes() const { return bytes_; }
	std::vector<uint8_t> get_bytes(adrs_t start_adrs, size_t len) const { return std::vector<uint8_t>(bytes_.begin() + start_adrs - load_adrs_, bytes_.begin() + start_adrs - load_adrs_ + len); };
	adrs_t load_adrs() const { return load_adrs_; }
	adrs_t last_adrs() const { return load_adrs_ + bytes_.size() - 1; }

	//	Get 1 byte
	uint8_t get(adrs_t adrs) const { check(adrs); return bytes_[adrs-load_adrs_]; }
	uint16_t get_word(adrs_t adrs) const { return get(adrs) + (get(adrs + 1) << 8); }
	uint16_t size() const { return bytes_.size(); }
	bool contains(adrs_t adrs) const { return adrs >= load_adrs_ && (size_t)(adrs)-load_adrs_ < bytes_.size(); }

private:
	std::vector<uint8_t> bytes_;
	adrs_t load_adrs_ = 0;

	void check( adrs_t adrs ) const
	{
		if (!contains(adrs))
		{
			fprintf( stderr, "Rom: address %04X out of bounds\n", adrs );
			throw std::runtime_error("Rom: address out of bounds");
		}
	}
};
