#include "ioinspector.h"

#include "ioport.h"
#include "codeinspector.h"
#include "modal.h"

IOInspectorPanel::IOInspectorPanel(UI& ui, uint8_t data)
    : InspectorPanel(ui, data)
{
    title_ = "I/O";
    data_changed();
}

std::unique_ptr<InspectorPanel<uint8_t>> IOInspectorPanel::duplicate() const
{
    auto res = std::make_unique<IOInspectorPanel>(ui_,data());
    *res = *this;
    return res;
}

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

    if (!port.comments().empty())
    {
        ImGui::Separator();
        ui_.draw_comments(port.comments(),false);
        if (!ui_.click_handled() && ImGui::IsItemClicked())
        {
           ui_.add_panel(std::make_unique<IOEditModal>(ui_, data()));
        }
    }

    bool found = false;
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

            found = true;
        }
    }

    if (!found)
    {
        ImGui::Text("\n\n\nPort %02XH is not directly referenced in the code", port.value());
        return ;
    }
}
