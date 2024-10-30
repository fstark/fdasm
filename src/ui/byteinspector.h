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
	void do_draw_data() override;

	static void DisplayInstruction(const UI& ui, const Instruction& instruction);
};
