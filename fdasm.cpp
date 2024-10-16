#include <iostream>
#include <fstream>
#include <vector>
#include "disassembler.h"

Disassembler *load_rom( const std::string rom_file, RomContents& rom_contents )
{
	std::ifstream file(rom_file, std::ios::binary);
	if (!file) {
		std::cout << "Failed to open file: " << rom_file << std::endl;
		return nullptr;
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
	auto res =  new Disassembler(buffer,0, std::make_shared<RomContents>(rom_contents));

	return res;
}

int main( int argc, char *argv[] )
{
	if (argc!=1 && argc != 3) {
		std::cerr << "Usage: " << argv[0] << " <rom file> <fdafile>" << std::endl;
		return 1;
	}

	const char *rom_file = "M100rom.bin";
	const char *fda_file = "M100rom.fda";

	if (argc==3)
	{
		rom_file = argv[1];
		fda_file = argv[2];
	}

	RomContents rom_contents( fda_file );

	Disassembler *disassembler = load_rom( rom_file, rom_contents );

	extern void ShowHelloWorldWindow( Disassembler *disassembler );
	extern int InitImgUI();
	InitImgUI();

	ShowHelloWorldWindow( disassembler );

	return 0;
}
