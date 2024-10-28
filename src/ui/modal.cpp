#include "modal.h"

#include "uicommon.h"

void Modal::DoDraw()
{

	ImGui::OpenPopup(title_.c_str());

	// Always center this window when appearing
	ImVec2 center = ImGui::GetMainViewport()->GetCenter();
	ImGui::SetNextWindowPos(center, ImGuiCond_Appearing, ImVec2(0.5f, 0.5f));

	if (ImGui::BeginPopupModal(title_.c_str(), NULL, ImGuiWindowFlags_AlwaysAutoResize))
	{
		DoDrawContent();
		first_open_ = false;
	}

	if (ImGui::Button("OK", ImVec2(120, 0)) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_Enter)) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_KeypadEnter)))
	{
		ImGui::CloseCurrentPopup();
		Apply();
		close();
	}
	ImGui::SameLine();
	if (ImGui::Button("Cancel", ImVec2(120, 0)) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_Escape)))
	{
		ImGui::CloseCurrentPopup();
		close();
	}
	ImGui::EndPopup();
}

#include "ui.h"

void LabelEditModal::DoDrawContent()
{
	// Add a text field for inputting a name
	ImGui::Text("Label name:");
	ImGui::SameLine();
	if (first_open_)
		ImGui::SetKeyboardFocusHere();
	ImGui::InputText("##name", name_buffer_, IM_ARRAYSIZE(name_buffer_));

	//  Drwopdown for label type
	ImGui::Text("Type:");
	ImGui::SameLine();
	ImGui::PushItemWidth(60);
	{
		const char* items[]     = { "Unknowns", "Code", "Strz", "80+Str", "2-chars Str", "Bytes", "Words" };
		static int map[]        = { Annotations::kUNKNOWN, Annotations::kCODE, Annotations::kSTRZ, Annotations::kSTR8S, Annotations::kSTRF2, Annotations::kDATA, Annotations::kDATAW };
		static int item_current = 0;

		// Get current label type
		auto lbl = Annotations::label_from_adrs(adrs_);
		if (lbl)
		{
			for (int i = 0; i < IM_ARRAYSIZE(map); i++)
			{
				if (map[i] == label_type_)
				{
					item_current = i;
					break;
				}
			}
		}
		ImGui::Combo("##Type", &item_current, items, IM_ARRAYSIZE(items));
		// Stores new display style
		label_type_ = (Annotations::RegionType)map[item_current];
	}
	ImGui::PopItemWidth();
	ImGui::SameLine();
}

void LabelEditModal::Apply()
{
	ui_.replace_label(name_buffer_, adrs_, label_type_);
}
