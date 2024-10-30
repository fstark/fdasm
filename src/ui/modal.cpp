#include "modal.h"

#include "uicommon.h"

void Modal::do_draw()
{

	ImGui::OpenPopup(title_.c_str());

	// Always center this window when appearing
	ImVec2 center = ImGui::GetMainViewport()->GetCenter();
	ImGui::SetNextWindowPos(center, ImGuiCond_Appearing, ImVec2(0.5f, 0.5f));

	if (ImGui::BeginPopupModal(title_.c_str(), NULL, ImGuiWindowFlags_AlwaysAutoResize))
	{
		do_draw_content();
		first_open_ = false;
	}

	if (ImGui::Button("OK", ImVec2(120, 0)) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_Enter)) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_KeypadEnter)))
	{
		ImGui::CloseCurrentPopup();
		apply();
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


LabelEditModal::LabelEditModal(UI& ui, adrs_t adrs, const std::string& /* label */)
	: Modal(ui)
	, adrs_{ adrs }
{
	title_          = "Edit Label";
	name_buffer_[0] = 0;
	Label* lbl      = ui_.explorer().annotations().label_from_adrs(adrs);
	label_type_     = Annotations::kCODE;
	if (lbl)
	{
		snprintf(name_buffer_, 128, "%s", lbl->name().c_str());
		label_type_ = lbl->type();
	}
}


void LabelEditModal::do_draw_content()
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
		auto lbl = ui_.explorer().annotations().label_from_adrs(adrs_);
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
}

void LabelEditModal::apply()
{
	ui_.replace_label(name_buffer_, adrs_, label_type_);
}





CommentEditModal::CommentEditModal(UI& ui, adrs_t adrs)
	: Modal(ui)
	, adrs_{ adrs }
{
	title_          = "Add/Edit/Remove Comment";
	comment_buffer_[0] = 0;
	const Comment* comment = ui_.explorer().annotations().comment_from_adrs(adrs);

	if (comment)
	{
		snprintf(comment_buffer_, 1024, "%s", comment->text().c_str());
	}
}


void CommentEditModal::do_draw_content()
{
	// Add a text field for inputting a name
	ImGui::Text("Comment:");
	ImGui::SameLine();
	if (first_open_)
		ImGui::SetKeyboardFocusHere();
	ImGui::InputText("##name", comment_buffer_, IM_ARRAYSIZE(comment_buffer_));
}

void CommentEditModal::apply()
{
	ui_.replace_comment(adrs_, comment_buffer_);
}
