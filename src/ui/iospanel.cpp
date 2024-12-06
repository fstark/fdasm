#include "iospanel.h"

#include "uicommon.h"
#include "ui.h"

#include "modal.h"

IOsPanel::IOsPanel(UI& ui)
    : Panel(ui)
{
    title_ = "I/O ports";
	has_resize = true;
}

void IOsPanel::do_draw()
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
    ImGui::Checkbox("Show all", &show_all_);

    ImGui::Text("Port   Name     RD WR");

    ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);

    std::string filter = filter_;
    std::transform(filter.begin(), filter.end(), filter.begin(), ::toupper);

    int port_number = -1;
    //  check if filter is 1 or two chars, in "0-9A-F"
    if (filter.size() == 1 && isxdigit(filter[0]))
    {
        port_number = std::stoi(filter, nullptr, 16);
    }
    else if (filter.size() == 2 && isxdigit(filter[0]) && isxdigit(filter[1]))
    {
        port_number = std::stoi(filter, nullptr, 16);
    }

    for (const auto& port_stat : ui_.explorer().xrefs().get_io_stats())
    {
        IOPort port = ui_.explorer().annotations().io_list().get_port(port_stat.port);

        bool exclude = false;   //  We display everything

        if (!show_all_ && port_stat.reads == 0 && port_stat.writes == 0)
            exclude = true;     //  We exclude if no reads or writes

        if (filter_[0])
            exclude = true;     //  Unless there is a filter

        if (port_number != -1 && port.value() == port_number)
            exclude = false;    //  We keep if port matches
        
        if (filter_[0] && port.name().find(filter) != std::string::npos)
            exclude = false;    //  We keep if text matches

        if (exclude)
            continue;

        ui_.DrawIOPort( port_stat.port, kDisplayHex );
        if (ImGui::IsItemClicked())
        {
            ui_.update_io_panel(port_stat.port);
        }
        ImGui::SameLine();
        if (!port.name().empty())
        {
            ui_.DrawIOPort( port_stat.port, kDisplayLabel );
            if (ImGui::IsItemClicked())
            {
                ui_.update_io_panel(port_stat.port);
            }
        }
        ImGui::SameLine(16*char_width_);
        if (port_stat.reads)
        {
            ImGui::Text("%2d", port_stat.reads );
            ImGui::SameLine();
        }
        else
        {
            ImGui::Text(" -");
            ImGui::SameLine();
        }
        if (port_stat.writes)
        {
            ImGui::Text("%2d", port_stat.writes );
            ImGui::SameLine();
        }
        else
        {
            ImGui::Text(" -");
            ImGui::SameLine();
        }
        if (!port.comments().empty())
        {
            ui_.draw_comments(port.comments(),false);
            if (!ui_.click_handled() && ImGui::IsItemClicked())
            {
                ui_.add_panel(std::make_unique<IOEditModal>(ui_, port.value()));
            }
            ImGui::SameLine();
        }
        ImGui::Text("");
    }

    ImGui::EndChild();
}
