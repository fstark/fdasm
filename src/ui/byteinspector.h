#pragma once

#include "panel.h"

class ByteInspectorPanel : public InspectorPanel<uint8_t>
{
public:
	ByteInspectorPanel(UI& ui, uint8_t data)
	    : InspectorPanel(ui, data)
	{
		title_ = "Byte";
	}
	void DoDraw() override;

	static void DisplayInstruction(const UI& ui, const Instruction& instruction);
};
