#include "adrsinspector.h"

#include "ui.h"
#include "uicommon.h"

AdrsInspectorPanel::AdrsInspectorPanel(UI& ui, adrs_t data)
    : InspectorPanel(ui, data)
{
	title_ = "Address";
	//  The label for this address if any
	label_    = Annotations::label_from_adrs(data_);
	xrefs_to_ = ui.explorer().xrefs().xrefs_to(data_);
}

void AdrsInspectorPanel::DoDraw()
{
	ImGui::PushFont(ui_.large_font());
	if (label_)
	{
		ImGui::Text("%s:", label_->name().c_str());
		ImGui::SameLine();
	}
	ImGui::Text("%04X", data_);
	ImGui::PopFont();
	ImGui::Separator();
	if (label_)
	{
		ImGui::Text("%s", label_->name().c_str());
	}

	for (const auto& ref : xrefs_to_)
	{
		auto adrs = ref.from_;

		switch (ref.type_)
		{
			case XRef::kJUMP:
				ui_.DrawAddress(adrs, UI::kDisplayDisplacement, UI::kInteractNone);
				// ImGui::TextColored(ImVec4(244/255.0, 71/255.0, 71/255.0, 1.0f), "%04X:", adrs);
				break;
			case XRef::kREF:
				ui_.DrawAddress(adrs, UI::kDisplayDisplacement, UI::kInteractNone);
				// ImGui::TextColored(ImVec4(71/255.0, 71/255.0, 244/255.0, 1.0f), "%04X:", adrs);
				break;
			case XRef::kDATA:
				ui_.DrawAddress(adrs, UI::kDisplayDisplacement, UI::kInteractNone);
				// ImGui::TextColored(ImVec4(128/255.0, 128/255.0, 128/255.0, 1.0f), "%04X:", adrs);
				break;
		}

		if (ImGui::IsItemClicked())
		{
			ui_.update_code_panel(adrs);
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
