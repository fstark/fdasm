#pragma once

#include "inspector.h"

#include <string>

//  This inspects an I/O port
class IOInspectorPanel : public InspectorPanel<uint8_t>
{
public:
	IOInspectorPanel(UI& ui, uint8_t data);

protected:
    std::unique_ptr<InspectorPanel<uint8_t>> duplicate() const override;

	void data_changed() override;
	void do_draw_data() override;
};
