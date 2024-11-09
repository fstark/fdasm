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

	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override
	{
		auto res = std::make_unique<AdrsInspectorPanel>(ui_,data());
		*res = *this;
		return res;
	}

	//	User interaction
	void select(adrs_t adrs);
	void select();

	//	Show the code at the given address
	//	#### Should probably be a static in code inspector
	void show_code(adrs_t adrs);

private:
	std::vector<XRef> xrefs_to_;
};
