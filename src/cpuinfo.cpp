#include "cpuinfo.h"

#include <stdio.h>
#include <iostream>

CPUInfo::CPUInfo( const std::string filename )
{
    instructions_.resize( 256 );

    // Read the file and populate the instruction set
    FILE *file = fopen( filename.c_str(), "r" );
    if (file == NULL)
    {
        std::cerr << "Failed to open file: " << filename << std::endl;
        return;
    }

    std::vector<std::string> lines;

    char line[256];
    while (fgets(line, sizeof(line), file))
    {
        if (line[0] == ';' || line[0] == '#')
            continue;
        // Remove the newline
        char *nl = strchr( line, '\n' );
        if (nl)
            *nl = 0;
        // Skip leading spaces
        char *p = line;
        while (*p == ' ')
            ++p;
        lines.push_back( p );
    }

    fclose( file );

    // Parse the lines
    auto l = lines.begin();
    while (l != lines.end())
    {
        // Parse the line
        // 06: MVI B, D8
        //     Move immediate 8-bit data to register B
        //     Flags affected: None
        //     B <- byte 2
        // Split the line into tokens
        
        if (l->empty())
        {
            ++l;
            continue;
        }

        // Opcode are the first 2 chars
        // std::clog << "[" << l->substr(0, 2) << "] " << *l << std::endl;
        uint8_t opcode = std::stoi( l->substr(0, 2), nullptr, 16 );
        // Opcode is the rest of the line
        std::string mnemonic = l->substr(4);

        //  Read description, flags and effect
        std::string description = *++l;
        std::string flags = *++l;

        // If the next line is not empty, it is the effect
        std::string effect;
        if (++l != lines.end() && !l->empty())
        {
            effect = *l;
            ++l;
        }

        Instruction i( opcode, mnemonic, description, flags, effect );
        instructions_[opcode] = i;
    }
}
