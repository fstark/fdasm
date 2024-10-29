#pragma once

#include "inspector.h"

class CodeInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	CodeInspectorPanel(UI& ui, adrs_t data);
	void DoDrawData() override;
	void scroll_to_line(int line);
	void scroll_to_adrs(int adrs);

protected:
	void data_changed() override;

private:
	// Label *label_; future
	std::vector<XRef> xrefs_to_;
	int target_line_ = -1; //  The line to scroll to (if !=-1)
};
