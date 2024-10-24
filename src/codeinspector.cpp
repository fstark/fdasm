#include "codeinspector.h"

#include "uicommon.h"
#include "ui.h"
#include "byteinspector.h"

CodeInspectorPanel::CodeInspectorPanel( UI &ui, adrs_t data ) : InspectorPanel( ui, data )
{
    title_ = "ROM Disassembly";
    has_resize = true;
}

void CodeInspectorPanel::DoDraw()
{
    // if (ImGui::CollapsingHeader("Display Options"))
    // {
    //     // Add buttons for "ASCII" and "Labels"
    //     ImGui::Checkbox("ASCII",&ui_.force_ascii_);
    //     ImGui::SameLine();
    //     ImGui::Checkbox("Labels",&ui_.force_labels_);
    // }

    ImGui::PushItemWidth(80);

    {
        const char* items[] = { "Hex", "Decimal", "Labels" };
        static int map[] = { UI::kDisplayHex, UI::kDisplayDecimal, UI::kDisplayDisplacement };
        static int item_current = 0;
        // find the current item from address_display_style_ (#### Can do C++ way)
        for (int i = 0; i < IM_ARRAYSIZE(map); i++)
        {
            if (map[i] == ui_.address_display_style_)
            {
                item_current = i;
                break;
            }
        }
        ImGui::Combo("##AdrsCol1", &item_current, items, IM_ARRAYSIZE(items));
        // Stores new display style
        ui_.address_display_style_ = (UI::eDisplayStyle)map[item_current];
    }
    ImGui::SameLine();
    {
        const char* items[] = { "Hex", "Ascii", "Decimal", "Binary", "Octal" };
        static int map[] = { UI::kDisplayHex, UI::kDisplayAscii, UI::kDisplayDecimal, UI::kDisplayBinary, UI::kDisplayOctal };
        static int item_current = 0;
        for (int i = 0; i < IM_ARRAYSIZE(map); i++)
        {
            if (map[i] == ui_.bytes_display_style_)
            {
                item_current = i;
                break;
            }
        }
        ImGui::Combo("##AdrsCol2", &item_current, items, IM_ARRAYSIZE(items));
        // Stores new display style
        ui_.bytes_display_style_ = (UI::eDisplayStyle)map[item_current];
    }
    ImGui::PopItemWidth();


    // Get imgui character width
    float char_width = ImGui::CalcTextSize("A").x;
    // 4 bytes + ':' + 8*2 bytes + 7 sep = 28 + 2 margins
    float adrs_width = 30*char_width;
    float label_width = 21*char_width;

    ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
    ImGuiListClipper clipper;
    // std::cout << "lines: " << ui_.lines().size() << std::endl;
    // std::cout << "line height: " << ImGui::GetTextLineHeightWithSpacing() << std::endl;
    clipper.Begin(ui_.lines().size(), ImGui::GetTextLineHeightWithSpacing());

// test
    if (target_line_!=-1)
    {
        float line_height_with_spacing = ImGui::GetTextLineHeightWithSpacing();
        float target_y = target_line_ * line_height_with_spacing;
        ImGui::SetScrollY(target_y);
        target_line_ = -1;
    }

    while (clipper.Step())
    {
        for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
        {
            const auto& line = ui_.lines()[i];

        // Set background color for even lines
        // if (i % 2 == 0)
        {
            // ImGui::PushStyleColor(ImGuiCol_Header, ImVec4(0.6f, 1.0f, 0.6f, 1.0f)); // Light green background
            // ImGui::PushStyleColor(ImGuiCol_HeaderHovered, ImVec4(0.7f, 1.0f, 0.7f, 1.0f)); // Slightly darker green when hovered
            // // ImGui::PushStyleColor(ImGuiCol_HeaderActive, ImVec4(0.8f, 1.0f, 0.8f, 1.0f)); // Slightly darker green when active

            // ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.8f, 1.0f, 0.8f, 1.0f)); // Slightly darker green when active
        // ImGui::Selectable(buff, false, ImGuiSelectableFlags_SpanAllColumns | ImGuiSelectableFlags_AllowItemOverlap, ImVec2(0, 0));
        // ImGui::SameLine();
            ImGui::Separator();
        }

        // char buff[16];
        // sprintf( buff, "##%i", i );

        // Use ImGui::Selectable to create a selectable item with the background color
        // ImGui::Selectable(buff, false, ImGuiSelectableFlags_SpanAllColumns | ImGuiSelectableFlags_AllowItemOverlap, ImVec2(0, 0));

        // Display line address and text in two columns
        // First one being constant size
        // ImGui::SameLine();

            // Draw the address of the current line
            // 4 digits hexadecimal
            if (!line.is_empty())
            {
                //  Address of the current instruction (column 1)
                auto display = ui_.address_display_style_;
                if (ui_.force_labels_)
                    display = UI::kDisplayDisplacement;
                
                ui_.DrawAddress( line.start_adrs_, display, UI::kInteractNone );
                ui_.hoover( line.start_adrs_, tag+0, ImGui::IsItemHovered() );

                ImGui::SameLine();

                //  Bytes of the current instruction (column 2)
                display = ui_.bytes_display_style_;
                if (ui_.force_ascii_)
                    display = UI::kDisplayAscii;

                for (int i = 0;i!=line.byte_count();i++)
                {
                    ui_.DrawByte( line.get_byte(i), display, UI::kInteractNone, line.start_adrs_+i );
                    ui_.hoover( line.start_adrs_+i, tag+1, ImGui::IsItemHovered() );
                }
            }
            else
            {
                ImGui::SameLine(label_width);
                if (ui_.is_hoover(line.start_adrs_))
                {
                    UI::Select( line.spans()[0].content().c_str() );
                    ImGui::TextColored( std_select_color, "%s:", line.spans()[0].content().c_str() );
                }
                else
                    ImGui::TextColored( std_color, "%s:", line.spans()[0].content().c_str() );
                ui_.hoover( line.start_adrs_, tag+3, ImGui::IsItemHovered() );
                ImGui::SameLine();
            }

            ImGui::SameLine(adrs_width);

            // Instruction (Column 3)
            if (!line.is_empty())
            for (const auto &span:line.spans())
            {
                auto color = std_color;
                bool hack = false;
                bool is_mnem = false;
                bool is_adrs = false;
                switch (span.get_type())
                {
                    case Span::kMnemonic:
                        color = mnemonic_color;
                        is_mnem = true;
                        break;
                    case Span::kAddress:
                        color = adrs_color;
                        is_adrs = true;
                        break;
                    case Span::kString:
                        color = string_color;
                        break;
                    default:
                        color = std_color;
                        break;
                }

                if (is_adrs)
                {
                    ui_.DrawAddress( span.adrs(), UI::kDisplayDisplacement, UI::kInteractNone );
                    ui_.hoover( span.adrs(), tag+2, ImGui::IsItemHovered() );
                    if (ImGui::IsItemClicked())
                    {
                        ui_.InspectAdrs( span.adrs(), false );
                    }
                }
                else
                {
                    ImGui::TextColored( color, "%s", span.content().c_str() );
                    if (is_mnem && ImGui::IsItemHovered())
                    {
                        ImGui::BeginTooltip();
                        auto v = ui_.explorer().rom().get(line.start_adrs_);
                        ByteInspectorPanel::DisplayInstruction( ui_, ui_.explorer().cpu_info().instruction( v ) );
                        ImGui::EndTooltip();
                    }
                    // if (is_adrs)
                    // {
                    //     ui_.hoover( span.adrs(), tag+1, ImGui::IsItemHovered() );
                    // }
                    // if (is_adrs && ImGui::IsItemClicked())
                    // {
                    //     ui_.InspectAdrs( span.adrs(), false );
                    // }
                }
                ImGui::SameLine();
            }
            ImGui::Text( "" );

        // Pop the style color for even lines
        // if (i % 2 == 0)
        // {
        //     ImGui::PopStyleColor(3);
        // }

        }
    }
    clipper.End();
    ImGui::EndChild();
}

