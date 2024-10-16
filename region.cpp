#include "region.h"
#include <cassert>
#include <stdio.h>

RomContents::RomContents( const char *filename )
{
    start_ = 0;
    end_ = 0x7fff;

    regions_.resize(end_-start_+1);

    set_region( 0, 0x7fff, kCODE );
    read_regions( filename );
}


/* Format of the region file:
0000-7FFF CODE
0003-0007 STRZ
0040-007F DATAW
0080-0260 STR8S
0261-0261 DATA
0262-02E1 DATAW
02E2-02F1 DATA
02F2-031B DATAW
031C-0359 STRF2
035A-035F DATAW
036F-03E9 DATA
03EA-0400 STRZ
*/
void RomContents::read_regions( const char * filename )
{
    FILE *file = fopen( filename, "r" );
    if (file == NULL)
    {
        printf( "Failed to open file: %s\n", filename );
        return;
    }

    char line[256];
    while (fgets(line, sizeof(line), file))
    {
        unsigned int start, end;
        char type[16];
        // fprintf( stderr, "> %s\n", line );
        if (sscanf(line, "%X-%X %s", &start, &end, type) == 3)
        {
            // fprintf( stderr, "     %x %x %s\n", start, end, type );
            RomContents::RegionType RegionType = RomContents::kUNKNOWN;
            if (strcmp(type, "CODE") == 0)
                RegionType = RomContents::kCODE;
            else if (strcmp(type, "STRZ") == 0)
                RegionType = RomContents::kSTRZ;
            else if (strcmp(type, "DATAW") == 0)
                RegionType = RomContents::kDATAW;
            else if (strcmp(type, "STR8S") == 0)
                RegionType = RomContents::kSTR8S;
            else if (strcmp(type, "DATA") == 0)
                RegionType = RomContents::kDATA;
            else if (strcmp(type, "STRF2") == 0)
                RegionType = RomContents::kSTRF2;
 
            set_region( start, end, RegionType );
        }
    }

    fclose(file);
}

RomContents::RegionType RomContents::get_region_type(adrs_t adrs)
{

   assert( adrs >= start_ && adrs <= end_ );
   return regions_[adrs-start_];
}

