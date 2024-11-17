#include "iospanel.h"

#include "uicommon.h"
#include "ui.h"

IOsPanel::IOsPanel(UI& ui)
    : Panel(ui)
{
    title_ = "I/O ports";
	has_resize = true;
}

void IOsPanel::do_draw()
{
    ImGui::Text("Port   Name     RD WR");

    ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);

    for (const auto& port_stat : ui_.explorer().xrefs().get_io_stats())
    {
        IOPort port = ui_.explorer().annotations().io_list().get_port(port_stat.port);
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
            for (auto &comment:port.comments())
            {
                ImGui::Text("");
                ImGui::SameLine(24*char_width_);
                ui_.draw_comment(comment,false);
            }
            ImGui::SameLine();
        }
        ImGui::Text("");
    }

    ImGui::EndChild();
}
