#pragma once

#include "panel.h"

#include "ioport.h"

#include <vector>

class IOsPanel : public Panel
{

public:
    IOsPanel(UI& ui);

protected:
    void do_draw() override;

    char filter_[256] = {0};

    std::vector<const IOPort *> read_;
    std::vector<const IOPort *> write_;

    bool reads_open_ = false;
    bool writes_open_ = false;
};
