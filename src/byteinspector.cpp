#include "byteinspector.h"

#include "uicommon.h"
#include "ui.h"

/* static */ void ByteInspectorPanel::DisplayInstruction( const UI &ui, const Instruction &instruction )
{
    ImGui::PushFont(ui.large_font());
    ImGui::Text("%s", instruction.mnemonic().c_str());
    ImGui::PopFont();
    ImGui::Separator();
    ImGui::PushTextWrapPos(320);
    ImGui::Text("%s", instruction.description().c_str());
    ImGui::Text("%s", instruction.flags().c_str());
    ImGui::Text("%s", instruction.effect().c_str());
    ImGui::PopTextWrapPos();
}

void ByteInspectorPanel::DoDraw()
{
    // Display the byte info in a large font

    char info_char_ = data_&0x7f;
    if (info_char_<32 || info_char_>126)
        info_char_ = ' ';

    ImGui::PushFont(ui_.large_font());
    ImGui::Text("%02X|%c|%3d|%03o|%c%c%c%c %c%c%c%c",
        data_,
        info_char_,
        data_,
        data_,
        data_&0x80?'1':'0',
        data_&0x40?'1':'0',
        data_&0x20?'1':'0',
        data_&0x10?'1':'0',
        data_&0x08?'1':'0',
        data_&0x04?'1':'0',
        data_&0x02?'1':'0',
        data_&0x01?'1':'0'
        );
    ImGui::PopFont();
    ImGui::PushFont(ui_.tiny_font());
    ImGui::Text("hex asc dec oct binary");
    ImGui::PopFont();
    ImGui::Separator();
    auto i = ui_.explorer().cpu_info().instruction(data_);
    DisplayInstruction( ui_, i );
}
