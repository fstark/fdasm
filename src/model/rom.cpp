#include "rom.h"

#include <fstream>
#include <iostream>
#include <string>

Rom::Rom(const std::string& rom_file, adrs_t load_adrs)
    : load_adrs_{ load_adrs }
{
	std::ifstream file(rom_file, std::ios::binary);
	if (!file)
	{
		std::cerr << "Failed to open file: [" << rom_file << "]" << std::endl;
		throw std::runtime_error("Failed to open ROM file");
	}

	// Get the size of the file
	file.seekg(0, std::ios::end);
	std::streampos fileSize = file.tellg();
	file.seekg(0, std::ios::beg);

	// Read the file into a buffer
	bytes_.resize(fileSize);
	file.read((char*)bytes_.data(), fileSize);

	// Close the file
	file.close();

	std::clog << "ROM loaded: " << rom_file << " " << bytes_.size() << " bytes" << std::endl;
}
