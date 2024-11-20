#pragma once

#include "cpuinfo.h"

#include <vector>

//	A guesser guesses the load address of a binary file
class Guesser
{
public:
	Guesser( const CPUInfo &cpu_info, std::vector<uint8_t> &bytes )
		: cpu_info_(cpu_info)
		, bytes_(bytes)
	{
	};

		//	Best match for load
	adrs_t matches() const;

		//	Perform a guess on a file
	static adrs_t guess( const char *filename );

protected:
	const CPUInfo &cpu_info_;
	std::vector<uint8_t> bytes_;
};
