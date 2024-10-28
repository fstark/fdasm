#pragma once

#include "inspector.h"

//  Inspects all the memory
class DataInspectorPanel : public Panel
{
public:
	DataInspectorPanel(UI& ui);
	void DoDraw() override;
	void scroll_to_adrs(adrs_t target_adrs)
	{
		target_line_ = target_adrs / 16; // hard coded
	}

private:
	int target_line_ = -1;
};
