#pragma once

#include "inspector.h"

class ByteInspectorPanel : public InspectorPanel<uint8_t>
{
public:
	ByteInspectorPanel(UI& ui, uint8_t data)
	    : InspectorPanel(ui, data)
	{
		title_ = "Byte";
	}

	static void DisplayInstruction(const UI& ui, const Instruction& instruction);

protected:
	void do_draw_data() override;

	std::unique_ptr<InspectorPanel<uint8_t>> duplicate() const override
	{
		auto res = std::make_unique<ByteInspectorPanel>(ui_,data());
		res->set_has_history(false);
		return res;
	}
};
