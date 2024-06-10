#include <iostream>
#include <fstream>
#include <vector>
#include "disassembler.h"

int main(int argc, char* argv[]) {
	if (argc != 3) {
		std::cout << "Usage: " << argv[0] << " --rom <file>" << std::endl;
		return 1;
	}

	std::string arg = argv[1];
	if (arg != "--rom") {
		std::cout << "Usage: " << argv[0] << " --rom <file>" << std::endl;
		return 1;
	}

	std::string filename = argv[2];
	std::ifstream file(filename, std::ios::binary);
	if (!file) {
		std::cout << "Failed to open file: " << filename << std::endl;
		return 1;
	}

	// Get the size of the file
	file.seekg(0, std::ios::end);
	std::streampos fileSize = file.tellg();
	file.seekg(0, std::ios::beg);

	// Read the file into a buffer
	std::vector<uint8_t> buffer(fileSize);
	file.read((char *)buffer.data(), fileSize);

	// Close the file
	file.close();

	// Disassemble the buffer
    Disassembler disassembler(buffer,0);
	disassembler.disassemble();

	return 0;
}
