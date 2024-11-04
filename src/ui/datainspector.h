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
	void do_draw_data() override;

	void data_changed() override;

	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override { return std::make_unique<DataInspectorPanel>(ui_/*,data()*/); }

	void draw_byte( adrs_t adrs );

	void draw_word( adrs_t adrs );

private:
	int target_line_ = -1;

	bool as_words_ = false;
};
