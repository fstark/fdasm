#include "modal.h"

#include "uicommon.h"

void Modal::draw()
{

	// Always center this window when appearing
	ImVec2 center = ImGui::GetMainViewport()->GetCenter();
	ImGui::SetNextWindowPos(center, ImGuiCond_Appearing, ImVec2(0.5f, 0.5f));

	ImGui::OpenPopup(title_.c_str());
	if (ImGui::BeginPopupModal(title_.c_str(), NULL, ImGuiWindowFlags_AlwaysAutoResize))
	{
		do_draw_content();
		first_open_ = false;

		if (ImGui::Button("OK", ImVec2(120, 0)) || (!disable_enter_ && ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_Enter))) || ImGui::IsKeyPressed(ImGui::GetKeyIndex(ImGuiKey_KeypadEnter)))
		{
			ImGui::CloseCurrentPopup();
			if (apply())
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
}

#include "ui.h"


LabelEditModal::LabelEditModal(UI& ui, adrs_t adrs, const std::string& label, bool edit_adrs )
	: Modal(ui)
	, adrs_{ adrs }
	, edit_adrs_{ edit_adrs }
{
	disable_enter_ = true;
	title_          = "Edit Label";
	strncpy( name_buffer_, label.c_str(), 128 );

	Label* lbl      = ui_.explorer().annotations().label_from_adrs(adrs_);
	label_type_     = Annotations::kCODE;
	snprintf( adrs_buffer_, 16, "%04X", adrs );

		//	Existing name
	if (lbl)
	{
		snprintf(name_buffer_, 128, "%s", lbl->name().c_str());
		label_type_ = lbl->type();
		strncpy( comment_buffer_, lbl->comment().c_str(), 16384 );
	}

	if (name_buffer_[0]==0)
	{	//	No name, we invent ours
		snprintf( name_buffer_, 128, "D%04X", adrs );
		comment_buffer_[0] = 0;
	}
}

void LabelEditModal::do_draw_content()
{
	if (edit_adrs_)
	{
		ImGui::Text("Address: ");
		ImGui::SameLine();
		ImGui::InputText("##adrs", adrs_buffer_, IM_ARRAYSIZE(adrs_buffer_));
	}

	// Add a text field for inputting a name
	ImGui::Text("Label name:");
	ImGui::SameLine();
	if (first_open_)
		ImGui::SetKeyboardFocusHere();
	ImGui::InputText("##name", name_buffer_, IM_ARRAYSIZE(name_buffer_));

	//  Dropdown for label type
	ImGui::Text("Type:");
	ImGui::SameLine();
	ImGui::PushItemWidth(60);
	{
		const char* items[]     = { "Code", "Strz", "80+Str", "2-chars Str", "Bytes", "Words" };
		static int map[]        = { Annotations::kCODE, Annotations::kSTRZ, Annotations::kSTR8S, Annotations::kSTRF2, Annotations::kDATA, Annotations::kDATAW };
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

	ImGui::Text("Comment:");
	ImGui::SameLine();
	ImGui::InputTextMultiline("##comment", comment_buffer_, IM_ARRAYSIZE(comment_buffer_), ImVec2(400, 100));
}

bool LabelEditModal::apply()
{
	//	We update the address if field was editable
	if (edit_adrs_)
	{
		adrs_ = strtol(adrs_buffer_, nullptr, 16);
	}

	//	We look if the label already exists at a different address
	Label* lbl = ui_.explorer().annotations().label_from_name(name_buffer_);
	if (lbl && lbl->adrs() != adrs_)
	{
		// Append a random number to the label
		char buffer[128];
		snprintf(buffer, 128, "%s_%d", name_buffer_, rand() % 1000);
		snprintf(name_buffer_, 128, "%s", buffer);

		lbl = ui_.explorer().annotations().label_from_name(name_buffer_);
		if (lbl)
			return false;
	}

	ui_.replace_label(name_buffer_, adrs_, label_type_, comment_buffer_);

	return true;
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
		snprintf(comment_buffer_, 1024, "%s", comment->comment_text().text().c_str());
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

bool CommentEditModal::apply()
{
	ui_.replace_comment(adrs_, comment_buffer_);
	return true;
}




IOEditModal::IOEditModal(UI& ui, uint8_t io_adrs ) : Modal(ui)
{
	title_ = "Edit I/O port";
	io_adrs_ = io_adrs;
	strncpy( name_buffer_, ui.explorer().annotations().io_list().get_port(io_adrs).name().c_str(), 128 );
	strncpy( comment_buffer_, ui.explorer().annotations().io_list().get_port(io_adrs).comment().c_str(), 16384 );
}

void IOEditModal::do_draw_content()
{
	// Add a text field for inputting a name
	ImGui::Text("Name:");
	ImGui::SameLine();
	if (first_open_)
		ImGui::SetKeyboardFocusHere();
	ImGui::InputText("##name", name_buffer_, IM_ARRAYSIZE(name_buffer_));

	// Add a text field for inputting a description
	ImGui::Text("Description:");
	ImGui::SameLine();
	ImGui::InputTextMultiline("##description", comment_buffer_, IM_ARRAYSIZE(comment_buffer_), ImVec2(400, 100));
}

bool IOEditModal::apply()
{
	ui_.replace_io(io_adrs_, name_buffer_, comment_buffer_);
	return true;
}
