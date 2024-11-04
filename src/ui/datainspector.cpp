#include "datainspector.h"

#include "uicommon.h"

#include "ui.h"
DataInspectorPanel::DataInspectorPanel(UI& ui)
    : InspectorPanel(ui,0)
{
	title_     = "Data";
	has_resize = true;
}

void DataInspectorPanel::data_changed()
{
	scroll_to_adrs( data() );
}

void DataInspectorPanel::do_draw_data()
{
	int bytes_per_line = 16;

	if (as_words_)
		bytes_per_line = 8;

	//	Add a checkbox "Words"
	ImGui::SameLine();
	if (ImGui::Checkbox("Words", &as_words_))
		;

	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
	ImGuiListClipper clipper;
	clipper.Begin(ui_.explorer().rom().size()/ bytes_per_line, ImGui::GetTextLineHeightWithSpacing());

	if (target_line_ != -1)
	{
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
			adrs_t adrs = i * bytes_per_line + ui_.explorer().rom().load_adrs();

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

			for (int i = 0; i != bytes_per_line; i++)
			{
				if (as_words_)
					draw_word( adrs+i );
				else
					draw_byte( adrs+i );
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
		paint_element( "00", ImGui::GetColorU32(bg_select_color) );
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
	ImGui::TextColored( byte_color, "%s", buffer );

	ImGui::SameLine();
}
