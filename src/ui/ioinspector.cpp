#include "ioinspector.h"

#include "ioport.h"
#include "codeinspector.h"
#include "modal.h"

void IOInspectorPanel::data_changed()
{
    // const IOPort &port = ui_.explorer().annotations().io_list().get_port(data());
}

void IOInspectorPanel::do_draw_data()
{
    const IOPort &port = ui_.explorer().annotations().io_list().get_port(data());

    if (port.name().empty())
    {
        ImGui::Text("Port %02XH", port.value());
        if (ImGui::IsItemClicked())
        {
           ui_.add_panel(std::make_unique<IOEditModal>(ui_, data()));
        }
    }
    else
    {
        ImGui::Text("%s", port.name().c_str());
        if (ImGui::IsItemClicked())
        {
           ui_.add_panel(std::make_unique<IOEditModal>(ui_, data()));
        }
    }
 
    ImGui::SameLine();
    if (ImGui::SmallButton("Edit..."))
    {
        ui_.add_panel(std::make_unique<IOEditModal>(ui_, data()));
    }

    if (!port.comment().empty())
    {
        ImGui::Separator();
        ImGui::Text("%s", port.comment().c_str());
    }

    for (auto &x:ui_.explorer().xrefs().get_io_refs())
    {
        if (x.port==data())
        {
            char buffer[256];
            snprintf( buffer, 256, "%02XH %s", x.port, x.is_read ? "Read" : "Write" );
            ImGui::SeparatorText(buffer);

            auto adrs = x.adrs;

            std::unique_ptr<CodeInspectorPanel> inspector = std::make_unique<CodeInspectorPanel>(ui_, adrs);

            auto index = ui_.disassembly().adrs_to_line(adrs);
            if (index>1) index -= 1;
            else index = 0;
            adrs = ui_.lines()[index]->start_adrs();

            inspector->code_preview( adrs, 2 );
        }
    }
}
