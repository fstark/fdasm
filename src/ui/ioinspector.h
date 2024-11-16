#pragma once

#include "inspector.h"

#include <string>

//  This inspects an I/O port
class IOInspectorPanel : public InspectorPanel<uint8_t>
{
public:
	IOInspectorPanel(UI& ui, uint8_t data)
	    : InspectorPanel(ui, data)
	{
		title_ = "I/O";
		data_changed();
	}

protected:
    std::unique_ptr<InspectorPanel<uint8_t>> duplicate() const override
	{
		auto res = std::make_unique<IOInspectorPanel>(ui_,data());
		*res = *this;
		return res;
	}

	void data_changed() override;
	void do_draw_data() override;
};
