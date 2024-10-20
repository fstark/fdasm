#include <iostream>
#include <fstream>
#include <vector>
#include "explorer.h"
#include "ui.h"

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

	Explorer explorer( "8085.txt", rom_file, fda_file );

	// Annotations rom_contents( fda_file );
	// Disassembler *disassembler = load_rom( rom_file, rom_contents );

	UI ui( explorer );
	ui.Run();

	return 0;
}
