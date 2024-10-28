#pragma once

#include "panel.h"

class CodeInspectorPanel : public InspectorPanel<adrs_t>
{
	// Label *label_; future
	std::vector<XRef> xrefs_to_;
	int target_line_ = -1; //  The line to scroll to (if !=-1)
public:
	CodeInspectorPanel(UI& ui, adrs_t data);
	void DoDraw() override;
	void scroll_to(int line) { target_line_ = line; }
};
