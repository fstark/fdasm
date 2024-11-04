#include "labelspanel.h"

#include "uicommon.h"

#include "ui.h"
#include "comment.h"
#include "modal.h"


#include <sstream>

LabelsPanel::LabelsPanel(UI& ui)
    : Panel(ui)
{
    title_ = "Labels";
	has_resize = true;
}

void LabelsPanel::draw_filter()
{
    ImGui::Text("Filter: ");
    ImGui::SameLine();
    ImGui::PushItemWidth(ImGui::CalcTextSize("W").x * 20);
    ImGui::InputText("##Filter", filter_, 256);
    ImGui::PopItemWidth();
    ImGui::SameLine();
    if (ImGui::Button("Clear"))
    {
        filter_[0] = 0;
    }

	ImGui::SameLine();
    if (ImGui::Button("New"))
        ui_.add_panel(std::make_unique<LabelEditModal>(ui_, 0x0000, "NAME",true));

    ImGui::Separator();

    //  Filter the labels
    std::string filter = filter_;
    std::transform(filter.begin(), filter.end(), filter.begin(), ::tolower);

    labels_.clear();
    if (filter_[0] != 0)
    {
        //  split filter by spaces
        std::vector<std::string> filters;
        std::istringstream iss(filter);
        for (std::string s; iss >> s; )
            filters.push_back(s);

        for (auto& label : ui_.explorer().annotations().get_labels())
        {
            // case insensitive search
            std::string name = label.name();
            std::transform(name.begin(), name.end(), name.begin(), ::tolower);
            bool match = true;
            for (const auto& f : filters)
            {
                if (name.find(f) == std::string::npos)
                {
                    match = false;
                    break;
                }
            }
            if (match)
                labels_.push_back(&label);
        }
    }
    else
    {
        for (auto& label : ui_.explorer().annotations().get_labels())
           labels_.push_back(&label);
    }
}

void LabelsPanel::do_draw()
{
	ImGuiListClipper clipper;

    draw_filter();

	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);

	clipper.Begin(labels_.size(), ImGui::GetTextLineHeightWithSpacing());

    //  Could handle a target_line_ to scroll to a specific label

	while (clipper.Step())
	{
		for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
		{
            auto& label = *labels_[i];
            adrs_t adrs = label.adrs();
            std::string name = label.name();
            const Comment *comment = ui_.explorer().annotations().comment_from_adrs(adrs);

		    std::string button_id = ICON_FA_CIRCLE_XMARK"##" + name;
			if (small_icon_button(button_id.c_str()))
                ;
            ImGui::SameLine();

                //  Label name
            ImGui::Text("%s", name.c_str());
            if (ImGui::IsItemClicked() && ui_.explorer().rom().contains(adrs))
            {
                ui_.update_adrs_panel(adrs);
                ui_.update_byte_panel(ui_.explorer().rom().get(adrs));
                ui_.update_code_panel(adrs);
            }
            ImGui::SameLine(100, 0);

                //  Label address
            ui_.DrawAddress(adrs, kDisplayHex, UI::kInteractNone);

                //  Type
            ImGui::SameLine();
            ImGui::TextColored(info_color, "%s", Annotations::region_type_name(label.type()).c_str());

                //  Label comment
            if (comment)
            {
                ImGui::SameLine(180);
                ImGui::TextColored(comment_color, "; %s", comment->text().c_str());
            }
            else
            {
                ImGui::SameLine();
                ImGui::Text("                 ");
            }
        }
	}

	clipper.End();
	ImGui::EndChild();
}
