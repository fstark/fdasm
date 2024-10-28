#include "datainspector.h"

#include "uicommon.h"

#include "ui.h"
DataInspectorPanel::DataInspectorPanel(UI& ui)
    : Panel(ui)
{
	title_     = "Data";
	has_resize = true;
}

void DataInspectorPanel::DoDraw()
{
	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
	ImGuiListClipper clipper;
	clipper.Begin(32768 / 16, ImGui::GetTextLineHeightWithSpacing());

	if (target_line_ != -1)
	{
		float line_height_with_spacing = ImGui::GetTextLineHeightWithSpacing();
		float target_y                 = target_line_ * line_height_with_spacing;
		ImGui::SetScrollY(target_y);
		target_line_ = -1;
	}

	while (clipper.Step())
	{
		for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
		{
			adrs_t adrs = i * 16;

			auto display = UI::kDisplayHex;
			if (ui_.force_labels_)
				display = UI::kDisplayDisplacement;

			ui_.DrawAddress(adrs, display, UI::kInteractNone);
			ui_.hoover(adrs, tag + 0, ImGui::IsItemHovered());

			ImGui::SameLine(0, 0);
			ImGui::Text(":");
			ImGui::SameLine();

			display = UI::kDisplayHex;
			if (ui_.force_ascii_)
				display = UI::kDisplayAscii;

			for (int i = 0; i != 16; i++)
			{
				ui_.DrawByte(ui_.explorer().rom().get(adrs + i), display, UI::kInteractNone, adrs + i);
				ui_.hoover(adrs + i, tag + 1, ImGui::IsItemHovered());
			}
			ImGui::Text("");
		}
	}

	clipper.End();
	ImGui::EndChild();
}
