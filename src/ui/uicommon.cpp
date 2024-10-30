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

auto line_color = ImVec4(40 / 255.0, 40 / 255.0, 40 / 255.0, 1.0f);

auto data_ref_color = ImVec4( 0.3f, 0.3f, 0.3f, 1.0f );

auto bg_select_color = ImVec4( 0.2f, 0.2f, 0.6f, 1.0f );

auto comment_color = ImVec4( 0.5f, 0.5f, 0.5f, 1.0f );

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
