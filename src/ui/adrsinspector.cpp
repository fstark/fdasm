#include "adrsinspector.h"

#include "ui.h"
#include "uicommon.h"
#include "codeinspector.h"
#include "modal.h"

const int INSTR_START_COLUMN = 20;
const int COMMENT_START_COLUMN = 26;

AdrsInspectorPanel::AdrsInspectorPanel(UI& ui, adrs_t d)
    : InspectorPanel(ui, d)
{
	title_ = "Address";
}

void AdrsInspectorPanel::data_changed()
{
	xrefs_to_ = ui_.explorer().xrefs().xrefs_to(data());
}

void AdrsInspectorPanel::select()
{
	select( data() );
}

void AdrsInspectorPanel::select(adrs_t adrs)
{
	if (!ui_.explorer().rom().contains(adrs))
		return;
	ui_.update_code_panel(adrs);
	ui_.update_byte_panel(ui_.explorer().rom().get(adrs));
	ui_.update_data_panel(adrs);
}

void AdrsInspectorPanel::show_code(adrs_t adrs)
{
	ImGui::BeginTooltip();
	std::unique_ptr<CodeInspectorPanel> inspector = std::make_unique<CodeInspectorPanel>(ui_, adrs);

	auto index = ui_.disassembly().adrs_to_line(adrs);
	if (index>4) index -= 4;
	else index = 0;
	adrs = ui_.lines()[index]->start_adrs();

	inspector->code_preview( adrs );
	ImGui::EndTooltip();
}

void AdrsInspectorPanel::do_draw_data()
{
	Label *label = ui_.explorer().annotations().label_from_adrs(data());

	//  Title = [LABEL:] HEX (DEC)
	ImGui::PushFont(ui_.large_font());
	if (label)
	{
		//	Label name if any
		ImGui::Text("%s:", label->name().c_str());
		if (ImGui::IsItemClicked())
		{
			select();
			if (ImGui::GetMouseClickedCount(0) == 2)
			{
				ui_.add_panel(std::make_unique<LabelEditModal>(ui_, data(), "",false));
			}
		}
		ImGui::SameLine();
	}
	ImGui::Text("%04X (%d)", data(), data());
	if (ImGui::IsItemClicked())
	{
		select();
		if (ImGui::GetMouseClickedCount(0) == 2)
		{
			ui_.add_panel(std::make_unique<LabelEditModal>(ui_, data(), "",false));
		}
	}
	ImGui::PopFont();
	ImGui::Separator();

	for (const auto& ref : xrefs_to_)
	{
		auto adrs = ref.from_;
        const Comment *comment = ui_.explorer().annotations().comment_from_adrs(adrs);

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
		if (ImGui::IsItemHovered())
			show_code( adrs );
		if (ImGui::IsItemClicked())
			select(adrs);

		ImGui::SameLine( INSTR_START_COLUMN * char_width_, 0);

		if (ref.instruction)
		{
			ImGui::TextColored(ImVec4(244 / 255.0, 71 / 255.0, 71 / 255.0, 1.0f), "%s", ref.instruction->shorter_mnemonic().c_str());
			if (ImGui::IsItemHovered())
				show_code( adrs );
			if (ImGui::IsItemClicked())
				select(adrs);
		}
		else
		{
			ImGui::TextColored(ImVec4(128 / 255.0, 128 / 255.0, 128 / 255.0, 1.0f), "DATA");
			if (ImGui::IsItemClicked())
				select(adrs);
		}


			//  Label comment
		if (comment)
		{
			ImGui::SameLine( COMMENT_START_COLUMN * char_width_, 0);
			ui_.draw_comment( adrs, comment->comment_text() );
			// ImGui::TextColored(ui_.preferences().get_color(Preferences::kCommentColor), "; %s", comment->text().c_str());
//	XXX
//	####
//	TODO
			if (ImGui::IsItemClicked())
				select(adrs);
		}
	}
}
