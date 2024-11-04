#include "adrsinspector.h"

#include "ui.h"
#include "uicommon.h"

AdrsInspectorPanel::AdrsInspectorPanel(UI& ui, adrs_t d)
    : InspectorPanel(ui, d)
{
	title_ = "Address";
}

void AdrsInspectorPanel::data_changed()
{
	xrefs_to_ = ui_.explorer().xrefs().xrefs_to(data());
}


void AdrsInspectorPanel::do_draw_data()
{
	ImGui::SameLine();

	Label *label = ui_.explorer().annotations().label_from_adrs(data());

	ImGui::PushFont(ui_.large_font());
	if (label)
	{
		ImGui::Text("%s:", label->name().c_str());
		ImGui::SameLine();
	}
	ImGui::Text("%04X", data());
	ImGui::PopFont();
	ImGui::Separator();
	if (label)
	{
		ImGui::Text("%s", label->name().c_str());
	}

	for (const auto& ref : xrefs_to_)
	{
		auto adrs = ref.from_;

		ImVec4 color = adrs_color;

		if (ref.from_data)
			color = data_ref_color;

		switch (ref.type_)
		{
			case XRef::kJUMP:
				ui_.DrawAddress(adrs, kDisplayDisplacement, UI::kInteractNone, color);
				// ImGui::TextColored(ImVec4(244/255.0, 71/255.0, 71/255.0, 1.0f), "%04X:", adrs);
				break;
			case XRef::kREF:
				ui_.DrawAddress(adrs, kDisplayDisplacement, UI::kInteractNone, color);
				// ImGui::TextColored(ImVec4(71/255.0, 71/255.0, 244/255.0, 1.0f), "%04X:", adrs);
				break;
			case XRef::kDATA:
				ui_.DrawAddress(adrs, kDisplayDisplacement, UI::kInteractNone, data_ref_color);
				// ImGui::TextColored(ImVec4(128/255.0, 128/255.0, 128/255.0, 1.0f), "%04X:", adrs);
				break;
		}

		if (ImGui::IsItemClicked())
		{
			ui_.update_code_panel(adrs);
			ui_.update_byte_panel(ui_.explorer().rom().get(adrs));
			ui_.update_data_panel(adrs);
		}

		if (ref.instruction)
		{
			ImGui::SameLine();
			ImGui::TextColored(ImVec4(244 / 255.0, 71 / 255.0, 71 / 255.0, 1.0f), "%s", ref.instruction->mnemonic().c_str());
		}
		else
		{
			ImGui::SameLine();
			ImGui::TextColored(ImVec4(128 / 255.0, 128 / 255.0, 128 / 255.0, 1.0f), "DATA");
		}
	}
}
