#pragma once

#include "panel.h"

#include <vector>

class LabelsPanel : public Panel
{

public:
    LabelsPanel(UI& ui);

protected:
    void draw_filter();
	void do_draw() override;

    char filter_[256] = {0};

    std::vector<const Label *> labels_;
};
