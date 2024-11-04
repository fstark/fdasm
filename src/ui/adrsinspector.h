#pragma once

#include "inspector.h"

//  This panel inspects an address
//  It displays the address, the label if any, and the xrefs to this address
//  It enables navigation to the xrefs
class AdrsInspectorPanel : public InspectorPanel<adrs_t>
{
public:
	AdrsInspectorPanel(UI& ui, adrs_t data);
	void do_draw_data() override;

protected:
	void data_changed() override;

	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override { return std::make_unique<AdrsInspectorPanel>(ui_,data()); }

private:
	std::vector<XRef> xrefs_to_;
};
