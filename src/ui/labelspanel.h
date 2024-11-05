#pragma once

#include "panel.h"

#include <vector>

class LabelsPanel : public Panel
{

public:
    LabelsPanel(UI& ui);

protected:
    void draw_filter();
    void edit_label(const Label& label);
    void edit_comment( adrs_t adrs );
    void go_to_adrs( adrs_t adrs ) const;
    void handle_adrs( adrs_t adrs );
	void do_draw() override;

    char filter_[256] = {0};

    std::vector<const Label *> labels_;
};
