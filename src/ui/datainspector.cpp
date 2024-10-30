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
	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
	ImGuiListClipper clipper;
	clipper.Begin(ui_.explorer().rom().size()/ 16, ImGui::GetTextLineHeightWithSpacing());

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
			adrs_t adrs = i * 16 + ui_.explorer().rom().load_adrs();

			auto display = UI::kDisplayHex;
			if (ui_.force_labels_)
				display = UI::kDisplayDisplacement;

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

			display = UI::kDisplayHex;
			if (ui_.force_ascii_)
				display = UI::kDisplayAscii;

			for (int i = 0; i != 16; i++)
			{
				//	If the line is selected, paint it
				if (adrs + i==data())
				{
					paint_element( "00", ImGui::GetColorU32(bg_select_color) );
				}

				ui_.DrawByte(ui_.explorer().rom().get(adrs + i), display, UI::kInteractNone, adrs + i);

				if (ImGui::IsItemClicked())
				{
					ui_.update_adrs_panel(adrs+i);
					ui_.update_byte_panel(ui_.explorer().rom().get(adrs+i));
					ui_.update_code_panel(adrs+i);
				}
				ui_.hoover(adrs + i, tag + 1, ImGui::IsItemHovered());
			}
			ImGui::Text("");
		}
	}

	clipper.End();
	ImGui::EndChild();
}
