#pragma once

#include "inspector.h"

//  Inspects all the memory
class DataInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	DataInspectorPanel(UI& ui);
	void scroll_to_adrs(adrs_t target_adrs)
	{
		target_line_ = target_adrs / 16; // hard coded
	}

protected:
	void DoDrawData() override;

	void data_changed() override;

private:
	int target_line_ = -1;
};
