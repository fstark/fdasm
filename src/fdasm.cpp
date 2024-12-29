#include "explorer.h"
#include "ui.h"
#include <fstream>
#include <iostream>
#include <vector>


#include "cpuinfo.h"
#include "resmanager.h"
#include "guesser.h"

void disass( CPUInfo& cpu_info, std::vector<uint8_t> &code, adrs_t adrs  )
{
	auto p = std::begin(code);
	while (p<std::end(code))
	{
		std::vector<uint8_t> data;

		auto opcode = *p;
		const Instruction &instr = cpu_info.instruction(opcode);
		printf( "%06X  ", adrs+static_cast<int>(p - std::begin(code)));

		printf( "%s", instr.short_mnemonic().c_str() );
		p++;
		if (instr.has_d8())
		{
			p++;
			printf( "%02XH", *p );
		}
		if (instr.has_d16())
		{
			int v = *p++;
			v += 256 * *p++;
			printf( "%04XH", v );
		}
		if (instr.has_adrs())
		{
			int v = *p++;
			v += 256 * *p++;
			printf( "%04XH", v );
		}
		if (instr.is_io_read())
		{
			printf( "              ; <---------------- IO READ" );
		}
		if (instr.is_io_write())
		{
			printf( "              ; <---------------- IO WRITE" );
		}
		printf( "\n" );
	}
}

void disass( const char *binary, adrs_t adrs )
{
	std::ifstream file(binary, std::ios::binary);
	if (!file)
	{
		std::cerr << "Cannot open file [" << binary << "]" << std::endl;
		throw std::runtime_error("Cannot open file");
	}

	std::vector<uint8_t> code;
	while (1)
	{
		uint8_t byte;
		file.read((char*)&byte, 1);
		if (file.eof())
			break;
		code.push_back(byte);
	}

	CPUInfo cpu_info("8085.txt");
	disass( cpu_info, code, adrs );
}

void usage( const char *exec )
{
	std::cerr << "Usage: " << std::endl;
	std::cerr << "  " << exec << " --rom <rom file> --fda <fdafile> --asm <asmfile> [--adrs adrs]" << std::endl;
	std::cerr << "      start a UI disassembly session for the rom file, storing projecy in the fda file." << std::endl;
	std::cerr << "      an asm file is generated." << std::endl;
	std::cerr << "      a load address can be optinally specified." << std::endl;
	std::cerr << "  " << exec << " --disass <rom file>" << std::endl;
	std::cerr << "      trivial disassembly, no labels, on output." << std::endl;
	std::cerr << "  " << exec << " --guess <rom file>" << std::endl;
	std::cerr << "      tries to guess the load address based on the jumps targets." << std::endl;
	exit( EXIT_FAILURE );
}

int main(int argc, char* argv[])
{
	adrs_t adrs = 0;
	const char *rom_file = "rom.bin";
	const char *fda_file = "rom.fda";
	const char *asm_file = "rom.asm";

	const char *exec = argv[0];

	std::string path = argv[0];
	auto pos = path.find_last_of('/');
	if (pos != std::string::npos)
	{
		path = path.substr(0, pos + 1);
		ResourceManager::register_path(path);
		ResourceManager::register_path(path+"/src");
		ResourceManager::register_path(path+"/src/external/imgui/misc/fonts");
	}

	argc--;
	argv++;

	while (argc)
	{
		if (argc>1 && !strcmp(argv[0],"--disass"))
		{
			disass( argv[1], adrs );
			argc--; argv++;
			return 0;
		}
		else if (argc>1 && !strcmp(argv[0],"--guess"))
		{
			Guesser::guess( argv[1] );
			argc--; argv++;
			return 0;
		}
		else if (argc>1 && !strcmp(argv[0],"--rom"))
		{
			rom_file = argv[1];
			argc--; argv++;
		}
		else if (argc>1 && !strcmp(argv[0],"--fda"))
		{
			fda_file = argv[1];
			argc--; argv++;
		}
		else if (argc>1 && !strcmp(argv[0],"--asm"))
		{
			asm_file = argv[1];
			argc--; argv++;
		}
		else if (argc>1 && !strcmp(argv[0],"--adrs"))
		{
			adrs = std::stoul(argv[1], nullptr, 16);
			std::clog << adrs << std::endl;
			argc--; argv++;
		}
		else
		{
			usage( exec );
		}

		argc--; argv++;
	}

//0xF7E9

	// Explorer explorer(
	// 		"8085.txt",
	// 		"/home/fred/Development/portal/disks/files/p_0006-0001_track00_0_hxcstream_afi/CP.O",
	// 		0x038,
	// 		"/home/fred/Development/portal/disks/files/CP.fda",
	// 		"/home/fred/Development/portal/disks/files/CP.asm"
	// 	);


	// Annotations rom_contents( fda_file );
	// Disassembler *disassembler = load_rom( rom_file, rom_contents );

	try
	{
		Explorer explorer("8085.txt", rom_file, adrs, fda_file, asm_file);
		UI ui(explorer);
		ui.run();
	}
	catch( std::exception &e )
	{
		std::cerr << "A fatal error occured: " << e.what() << std::endl;
		usage( exec );
	}
	return 0;
}
