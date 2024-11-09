#pragma once

#include "inspector.h"

//  Inspects all the memory
class DataInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	DataInspectorPanel(UI& ui);
	void scroll_to_adrs(adrs_t target_adrs)
	{
		target_line_ = (target_adrs- ui_.explorer().rom().load_adrs()) / bytes_per_line_;
	}

protected:
	void do_draw_data() override;

	void data_changed() override;

	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override
	{
		auto res = std::make_unique<DataInspectorPanel>(ui_);
		*res = *this;
		return res;
	}

	void paint_selection_if_needed( int line );
	void draw_byte( adrs_t adrs );
	void draw_word( adrs_t adrs );
	void draw_graphics( adrs_t adrs );

private:
	int target_line_ = -1;		//	The line we want to scroll to

	int targetted_line_ = -1;	//	The line we have scrolled to

	int bytes_per_line_ = 16;

	int type_ = 0; // 0=bytes, 1=words, 2=graphics
};
