#pragma once

#include "inspector.h"

class Comment;

class CodeInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	CodeInspectorPanel(UI& ui, adrs_t data);
	void do_draw_data() override;
	void scroll_to_line(int line);
	void scroll_to_adrs(int adrs);

protected:
	void data_changed() override;

	//	#### Lacks auto-scrolling
	//	Maybe capture the top-line at each frame and copy it?
	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override
	{
		auto res = std::make_unique<CodeInspectorPanel>(ui_,data());
		*res = *this;
		return res;
	}

private:
	int target_line_ = -1; 				//  The line to scroll to (if !=-1)

	eDisplayStyle address_display_style_ = kDisplayHex;
	eDisplayStyle bytes_display_style_   = kDisplayHex;
};
