#pragma once

#include "panel.h"

//  Inspects all the memory
class DataInspectorPanel : public Panel
{
    int target_line_ = -1;

public:
    DataInspectorPanel( UI &ui );
    void DoDraw() override;
    void scroll_to( adrs_t target_adrs )
    {
        target_line_ = target_adrs/16;// hard coded
    }
};
