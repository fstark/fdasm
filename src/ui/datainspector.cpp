#include "datainspector.h"

#include "uicommon.h"

#include "ui.h"
DataInspectorPanel::DataInspectorPanel(UI& ui)
    : InspectorPanel(ui,0)
{
	title_     = ICON_FA_CHART_SIMPLE" Data";
	has_resize = true;
}

void DataInspectorPanel::data_changed()
{
	scroll_to_adrs( data() );
}

void DataInspectorPanel::paint_selection_if_needed( int line )
{
	//	If the line is selected, paint it
	if (line==targetted_line_)
	{
		paint_line( ImGui::GetColorU32(ui_.preferences().get_color(Preferences::kLineSelectionColor)) );
	}
}

void DataInspectorPanel::do_draw_data()
{
	bytes_per_line_ = 1;
	
	switch (type_)
	{
		case 0:
			bytes_per_line_ = 16;
			break;
		case 1:
			bytes_per_line_ = 8;
			break;
		case 2:
			bytes_per_line_ = 1;
			break;
		default:
			break;
	}

	ImGui::SameLine();
	ImGui::RadioButton("Bytes", &type_, 0); ImGui::SameLine();
	ImGui::RadioButton("Words", &type_, 1); ImGui::SameLine();
	ImGui::RadioButton("Graphics", &type_, 2);


	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
	ImGuiListClipper clipper;
	clipper.Begin(ui_.explorer().rom().size()/ bytes_per_line_, ImGui::GetTextLineHeightWithSpacing());

	if (target_line_ != -1)
	{
		targetted_line_ = target_line_;
		float line_height_with_spacing = ImGui::GetTextLineHeightWithSpacing();
		target_line_ -= 5;
		if (target_line_ < 0)
			target_line_ = 0;
		float target_y                 = target_line_ * line_height_with_spacing;
		ImGui::SetScrollY(target_y);
		target_line_ = -1;
	}

	while (clipper.Step())
	{
		for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
		{
			paint_selection_if_needed(i);

			adrs_t adrs = i * bytes_per_line_ + ui_.explorer().rom().load_adrs();

			auto display = kDisplayHex;
			if (ui_.force_labels_)
				display = kDisplayDisplacement;

			ui_.DrawAddress(adrs, display, UI::kInteractNone);
			if (ImGui::IsItemClicked())
			{
				ui_.update_adrs_panel(adrs);
				ui_.update_byte_panel(ui_.explorer().rom().get(adrs));
				ui_.update_code_panel(adrs);
			}

			ui_.hoover(adrs, tag + 0, ImGui::IsItemHovered());

			ImGui::SameLine(0, 0);
			ImGui::Text(":");
			ImGui::SameLine();

			for (int i = 0; i != bytes_per_line_; i++)
			{
				switch (type_)
				{
					case 0:
						draw_byte(adrs + i);
						break;
					case 1:
						draw_word(adrs + i);
						break;
					case 2:
						draw_graphics(adrs + i);
						break;
				}
			}
			ImGui::Text("");
		}
	}

	clipper.End();
	ImGui::EndChild();
}

void DataInspectorPanel::draw_byte( adrs_t adrs )
{
	//	If the byte is selected, paint it
	if (adrs==data())
	{
		paint_element( "00", ImGui::GetColorU32(ui_.preferences().get_color(Preferences::kLineSelectionColor)) );
	}

	auto display = kDisplayHex;
	if (ui_.force_ascii_)
		display = kDisplayAscii;

	ui_.DrawByte(ui_.explorer().rom().get(adrs), display, UI::kInteractNone, adrs);

	if (ImGui::IsItemClicked())
	{
		ui_.update_adrs_panel(adrs);
		ui_.update_byte_panel(ui_.explorer().rom().get(adrs));
		ui_.update_code_panel(adrs);
	}
	ui_.hoover(adrs, tag + 1, ImGui::IsItemHovered());
}

void DataInspectorPanel::draw_word( adrs_t adrs )
{
	char buffer[256];
	uint8_t byte;

		//	Can we display a 16 bits value?
	if (ui_.explorer().rom().contains(adrs+1))
	{
			//	Check if we want to hilight it
		uint16_t val = ui_.explorer().rom().get_word(adrs);
		if (ui_.is_hoover(val))
			UI::DrawSelectRect( "0000", select_color );

		byte = ui_.explorer().rom().get(adrs+1);

		format_byte( buffer, byte, kDisplayHex );
		ImGui::TextColored( info_color, "%s", buffer );

		//	#### This code is duplicated
		//	also we probably would want to do some hover on the word value too
		if (ImGui::IsItemClicked())
		{	//	We go to the displayed *content*
			ui_.update_adrs_panel(val);
			if (ui_.explorer().rom().contains(val))
				ui_.update_byte_panel(ui_.explorer().rom().get(val));
			ui_.update_code_panel(val);
		}

		ImGui::SameLine(0,0);
	}
	else
	{
			//	End of screen
		ImGui::Text( "  " );
		ImGui::SameLine(0,0);
	}

	if (ui_.is_hoover(adrs))
	{
		UI::DrawSelectRect( "00" );
	}

	byte = ui_.explorer().rom().get(adrs);
	format_byte( buffer, byte, kDisplayHex );
	ImGui::TextColored( ui_.preferences().get_color(Preferences::kByteColor), "%s", buffer );

	if (ui_.explorer().rom().contains(adrs+1))	// Special case for end of window
	{
		uint16_t val = ui_.explorer().rom().get_word(adrs);
		if (ImGui::IsItemClicked())
		{	//	We go to the displayed *content*
			ui_.update_adrs_panel(val);
			if (ui_.explorer().rom().contains(val))
				ui_.update_byte_panel(ui_.explorer().rom().get(val));
			ui_.update_code_panel(val);
		}
	}

	ImGui::SameLine();
}

void DataInspectorPanel::draw_graphics( adrs_t adrs )
{
	uint8_t byte = ui_.explorer().rom().get(adrs);
	ImDrawList* draw_list = ImGui::GetWindowDrawList();
	ImVec2 p = ImGui::GetCursorScreenPos();
	float size = 16.0f;
	for (int j = 0; j < 8; ++j)
	{
		bool bit = byte & 0x80;
		byte <<= 1;
		if (bit)
			draw_list->AddRectFilled(ImVec2(p.x + j * size, p.y), ImVec2(p.x + (j+1)*size - 1, p.y + size), IM_COL32(230, 230, 230, 255));
	}
}
