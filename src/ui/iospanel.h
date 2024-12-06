#pragma once

#include "panel.h"

#include "ioport.h"

#include <vector>

//  This panel shows all the I/O ports
class IOsPanel : public Panel
{

public:
    IOsPanel(UI& ui);

protected:
    void do_draw() override;

    char filter_[256] = {0};    //  Current text or hex filter
    bool show_all_ = false;     //  Show all ports

    std::vector<const IOPort *> read_;
    std::vector<const IOPort *> write_;

    bool reads_open_ = false;
    bool writes_open_ = false;
};
