#include "annotations.h"
#include <cassert>
#include <stdio.h>
#include "label.h"
#include <map>
#include <unordered_map>
#include <string>

Annotations::Annotations( const std::string &filename )
{
    start_ = 0;
    end_ = 0x7fff;

    regions_.resize(end_-start_+1);

    set_region( 0, 0x7fff, kCODE );
    read_regions( filename );
}

static std::vector<Label> sLabels;
static std::unordered_map<adrs_t, Label> sLabelMap;

void Annotations::read_regions( const std::string &filename )
{
    FILE *file = fopen( filename.c_str(), "r" );
    if (file == NULL)
    {
        printf( "Failed to open file: %s\n", filename.c_str() );
        return;
    }

    char line[256];
    while (fgets(line, sizeof(line), file))
    {
        unsigned int adrs;
        char type[16];
        char label[16];
        *label = 0;
        // fprintf( stderr, "> %s\n", line );
        int n;
        if ((n=sscanf(line, "%X %s %s", &adrs, type, label)))
        {
            // fprintf( stderr, "     %x %x %s\n", start, end, type );
            Annotations::RegionType RegionType = Annotations::kUNKNOWN;
            if (strcmp(type, "CODE") == 0)
                RegionType = Annotations::kCODE;
            else if (strcmp(type, "STRZ") == 0)
                RegionType = Annotations::kSTRZ;
            else if (strcmp(type, "DATAW") == 0)
                RegionType = Annotations::kDATAW;
            else if (strcmp(type, "STR8S") == 0)
                RegionType = Annotations::kSTR8S;
            else if (strcmp(type, "DATA") == 0)
                RegionType = Annotations::kDATA;
            else if (strcmp(type, "STRF2") == 0)
                RegionType = Annotations::kSTRF2;
 
            sLabels.push_back( { static_cast<adrs_t>(adrs), 0, label, RegionType } );
        }
    }

    // Sorts the labels by address
    std::sort(sLabels.begin(), sLabels.end(), [](const Label &a, const Label &b) { return a.start_adrs() < b.start_adrs(); });

    sLabelMap.clear();
    for (const auto &label : sLabels)
    {
        sLabelMap.emplace(label.start_adrs(), label);
    }

    //  Sets the end address of each label
    for (size_t i = 0; i < sLabels.size() - 1; i++)
    {
        sLabels[i].set_end_adrs(sLabels[i + 1].start_adrs() - 1);
    }
    sLabels.back().set_end_adrs(0x7fff);    // #### hard-coded

    fclose(file);
}

Annotations::RegionType Annotations::get_region_type(adrs_t adrs)
{
    // Find in the sLabels sorted array
    // the last one that is less than adrs

    for (auto it = sLabels.rbegin(); it != sLabels.rend(); it++)
    {
        if (it->start_adrs()<= adrs)
            return it->type();
    }

    return kCODE;
}

Label *Annotations::label_from_adrs(adrs_t adrs)
{
    auto it = sLabelMap.find(adrs);
    if (it != sLabelMap.end())
        return &it->second;
    return nullptr;
}

const std::vector<Label> &Annotations::get_labels()
{
    return sLabels;
}
