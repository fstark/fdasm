#include "explorer.h"
#include "ui.h"
#include <fstream>
#include <iostream>
#include <vector>

int main(int argc, char* argv[])
{
	if (argc != 1 && argc != 3)
	{
		std::cerr << "Usage: " << argv[0] << " <rom file> <fdafile>" << std::endl;
		return 1;
	}

	// const char *rom_file = "M100rom.bin";
	// const char *fda_file = "M100rom.fda";

	const char *rom_file = "vdp-80.rom";
	const char *fda_file = "vdp-80.fda";

	if (argc == 3)
	{
		rom_file = argv[1];
		fda_file = argv[2];
	}

	Explorer explorer("8085.txt", rom_file, 0xd800, fda_file);

	// Annotations rom_contents( fda_file );
	// Disassembler *disassembler = load_rom( rom_file, rom_contents );

	UI ui(explorer);
	ui.run();

	return 0;
}
