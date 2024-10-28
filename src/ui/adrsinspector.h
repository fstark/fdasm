#pragma once

#include "panel.h"

class AdrsInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	AdrsInspectorPanel(UI& ui, adrs_t data);
	void DoDraw() override;

private:
	Label* label_;
	std::vector<XRef> xrefs_to_;
};
