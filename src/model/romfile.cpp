#include "romfile.h"

#include <string>
#include <iostream>
#include <fstream>

ROMFile::ROMFile( const std::string &rom_file, adrs_t load_adrs ) : load_adrs_{ load_adrs }
{
    std::ifstream file(rom_file, std::ios::binary);
    if (!file) {
        std::cout << "Failed to open file: " << rom_file << std::endl;
        return ;
    }

    // Get the size of the file
    file.seekg(0, std::ios::end);
    std::streampos fileSize = file.tellg();
    file.seekg(0, std::ios::beg);

    // Read the file into a buffer
    bytes_.resize(fileSize);
    file.read((char *)bytes_.data(), fileSize);

    // Close the file
    file.close();
}
