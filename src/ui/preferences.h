#pragma once

#include "panel.h"
#include "uicommon.h"

//  The preferences for the UI
class Preferences : public Panel
{
public:
    Preferences( UI& ui );

    typedef enum
    {
        kAdrsColorCodeHex,
        kAdrsColorDataHex,
        kAdrsColorCodeRom,
        kAdrsColorDataRom,
        kAdrsColorCodeLabel,
        kAdrsColorDataLabel,
        kAdrsColorCodeLocalLabel,
        kAdrsColorDataLocalLabel,
        kAdrsColorCodeGlobalLabel,
        kAdrsColorDataGlobalLabel,
        kAdrsColorCodeLocalLabelRom,
        kAdrsColorDataLocalLabelRom,
        kByteColor,
        kByteSelectColor,
        kOpCodeColor,
        kOperandColor,//UNUSED
        kCommentColor,
        kLabelColor,
        kSelectedLabelColor,
        kStringColor,
        kLineSelectionColor,
        kCount
    } eColors;

    const ImVec4 &get_color( int i ) const;

protected:
    void save() const;
    void load();

    void do_draw();

    static const int COLOR_COUNT = eColors::kCount;

    ImVec4 colors_[COLOR_COUNT];
};
