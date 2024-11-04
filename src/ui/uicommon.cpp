#include "uicommon.h"

auto dbg_color = ImVec4(0 / 255.0, 255 / 255.0, 0 / 255.0, 1.0f);

auto adrs_color        = ImVec4(244 / 255.0, 71 / 255.0, 71 / 255.0, 1.0f);
auto byte_color        = ImVec4(71 / 255.0, 244 / 255.0, 71 / 255.0, 1.0f);
auto byte_select_color = ImVec4(35 / 255.0, 122 / 255.0, 35 / 255.0, 1.0f);
auto data_color        = ImVec4(0.8f, 0.8f, 0.1f, 1.0f);

auto std_color        = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
auto std_select_color = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
auto mnemonic_color   = ImVec4(84 / 255.0, 147 / 255.0, 201 / 255.0, 1.0f);
auto string_color     = ImVec4(198 / 255.0, 140 / 255.0, 116 / 255.0, 1.0f);

auto select_color = ImVec4(255 / 255.0, 255 / 255.0, 255 / 255.0, 1.0f);
auto select_color2 = ImVec4(255 / 255.0, 192 / 255.0, 192 / 255.0, 1.0f);

auto line_color = ImVec4(40 / 255.0, 40 / 255.0, 40 / 255.0, 1.0f);

auto data_ref_color = ImVec4( 0.3f, 0.3f, 0.3f, 1.0f );

auto bg_select_color = ImVec4( 0.2f, 0.2f, 0.6f, 1.0f );

auto comment_color = ImVec4( 0.9f, 0.9f, 0.9f, 1.0f );
auto comment_light_color = ImVec4( 0.5f, 0.5f, 0.5f, 1.0f );

auto info_color = ImVec4( 0.5f, 0.5f, 0.5f, 1.0f );

void paint_line(ImU32 color)
{
	ImVec2 text_size  = ImGui::CalcTextSize("");
	ImVec2 cursor_pos = ImGui::GetCursorScreenPos(); // left of line
	cursor_pos.y -= 2;
	ImGui::GetWindowDrawList()->AddRectFilled(cursor_pos, ImVec2(cursor_pos.x + ImGui::GetWindowWidth(), cursor_pos.y + text_size.y + 3), ImGui::GetColorU32(color));
}

void paint_element( const char *str, ImU32 color)
{
    ImVec2 rect_min = ImGui::GetCursorScreenPos();
	ImVec2 text_size  = ImGui::CalcTextSize(str);
    ImVec2 rect_max = ImVec2(rect_min.x + text_size.x, rect_min.y + text_size.y);
	ImGui::GetWindowDrawList()->AddRectFilled(rect_min, rect_max, ImGui::GetColorU32(color));
}

void format_byte( char *buffer, uint8_t byte, eDisplayStyle display_style )
{
	switch (display_style)
	{
		case kDisplayHex:
			snprintf(buffer, 256, "%02x", byte);
			break;
		case kDisplayAscii:
		{
			uint8_t c = byte & 0x7f;
			if (c < 32 || c > 127)
				c = ' ';
			snprintf(buffer, 3, "%c ", c);
			break;
		}
		case kDisplayBinary:
			snprintf(buffer, 256, "%c%c%c%c%c%c%c%c",
			    byte & 0x80 ? '1' : '0',
			    byte & 0x40 ? '1' : '0',
			    byte & 0x20 ? '1' : '0',
			    byte & 0x10 ? '1' : '0',
			    byte & 0x08 ? '1' : '0',
			    byte & 0x04 ? '1' : '0',
			    byte & 0x02 ? '1' : '0',
			    byte & 0x01 ? '1' : '0');
			break;
		case kDisplayOctal:
			snprintf(buffer, 256, "%03o", byte);
			break;
		case kDisplayDecimal:
			snprintf(buffer, 256, "%3d", byte);
			break;
		default:
			snprintf(buffer, 256, "??");
			break;
	}
}

#include "imgui_internal.h"

#include <iostream>

//  A small icon button
//	This is a cathedral of hacks to get the icon correctly placed
bool small_icon_button(const char* label)
{
    ImGuiContext& g = *GImGui;

        //  No background, blue text
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0, 0, 0, 0)); // Transparent background
    ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0, 0, 0, 0));
    ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0, 0, 0, 0));
    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.160f, 0.290f, 0.480f, 0.540f));

        //  Changes to get the icon correctly placed
    float backup_padding_y = g.Style.FramePadding.y;
    g.Style.FramePadding.y = 0.5f;

        //  To be able to redraw the button if hover
    auto v = ImGui::GetCursorPos();

        //  Draw the button
    bool pressed = ImGui::ButtonEx(label, ImVec2(20, 12), ImGuiButtonFlags_AlignTextBaseLine);

        //  Button is hover, we redraw with a different text color
    if (ImGui::IsItemHovered())
    {
        ImGui::SetCursorPos(v);
        ImGui::PushStyleColor(ImGuiCol_Text, select_color);
        ImGui::PushID(label);
        ImGui::ButtonEx(label, ImVec2(20, 12), ImGuiButtonFlags_AlignTextBaseLine);
        ImGui::PopID();
        ImGui::PopStyleColor();
    }

        //  Restore changes
    g.Style.FramePadding.y = backup_padding_y;
    ImGui::PopStyleColor(4); // Restore previous colors
g.Style.ItemSpacing.y = 4 ;

    return pressed;
}
