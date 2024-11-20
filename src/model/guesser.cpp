#include "guesser.h"

#include <cassert>

#include <iostream>
#include <fstream>

int count_matches( int offset, std::vector<bool> starts, std::vector<int> targets )
{
	assert( offset + starts.size() <= targets.size() );
	int count = 0;
	for (int i=0; i<(int)starts.size(); i++)
	{
		if (starts[i] && targets[i+offset])
			// count += targets[i+offset];
			count ++;
	}
	return count;
}

adrs_t Guesser::matches() const
{
	//	We scan for all possible routines start
	//	(at the beginning of the rom + after every RET and JMP)
	std::vector<bool> starts( bytes_.size(), false );
	starts[0] = true;
	for (int i=0; i<(int)bytes_.size(); i++)
	{
		if (bytes_[i]==0xC9)
			if (i+1<(int)bytes_.size())
				starts[i+1] = true;
		if (bytes_[i]==0xC3)
			if (i+3<(int)bytes_.size())
				starts[i+3] = true;
	}

	//	We now scan for all absolute jump targets
	std::vector<int> targets( 65536, 0 );
	for (int i=0; i<(int)bytes_.size()-2; i++)
	{
		Instruction instr = cpu_info_.instruction( bytes_[i] );
		// if (instr.is_jump())
		if (instr.has_adrs() || instr.has_d16())
		{
			int target = bytes_[i+1] + 256*bytes_[i+2];
			targets[target]++;
		}
	}

	adrs_t max_offset = 0;
	int max_matches = 0;

	int offset_count = 65536-(int)bytes_.size();
	std::vector<int> matches( offset_count+1, 0 );

// printf( "size: %d\n", (int)bytes_.size() );
// printf( "offset_count: %04X\n", offset_count );

	//	We now scan for all possible routines start
	for (adrs_t offset=0;offset<=offset_count;offset++)
	{
		int count = count_matches( offset, starts, targets );
		matches[offset] = count;
		if (count>=max_matches)
		{
			max_matches = count;
			max_offset = offset;
		}
		fprintf( stdout, "%04X/%04X: %d (best %04X:%d)  \r", offset, offset_count, count, max_offset, max_matches );
		// fflush( stdout );
	}

	fprintf( stdout, "\n" );

#if 0
	//	Find the index and the value of the top 64 elements of matches
	std::vector<std::tuple<int,int>> top;
	for (int i=0;i<16;i++)
	{
		int max = 0;
		int index = 0;
		for (int j=0;j<(int)matches.size();j++)
		{
			if (matches[j]>max)
			{
				max = matches[j];
				index = j;
			}
		}
		top.push_back( { index, max } );
		matches[index] = 0;
	}

	//	Display the top matches
	for (auto &t: top)
	{
		fprintf( stdout, "%04X: %d\n", std::get<0>(t), std::get<1>(t) );
	}
#endif

	return max_offset;
}

adrs_t Guesser::guess( const char *filename )
{
	CPUInfo cpu_info("8085.txt");
	//	Read file
	std::ifstream file(filename, std::ios::binary);
	if (!file)
	{
		std::cerr << "Failed to open file: [" << filename << "]" << std::endl;
		throw std::runtime_error("Failed to open file");
	}
	std::vector<uint8_t> bytes;
	while (true)
	{
		uint8_t byte;
		file.read((char*)&byte, 1);
		if (file.eof()) break;
		bytes.push_back(byte);
	}
	Guesser guesser(cpu_info, bytes);
	return guesser.matches();
}
