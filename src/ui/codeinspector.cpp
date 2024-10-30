#include "codeinspector.h"

#include "byteinspector.h"
#include "modal.h"
#include "ui.h"
#include "uicommon.h"

CodeInspectorPanel::CodeInspectorPanel(UI& ui, adrs_t data)
    : InspectorPanel(ui, data)
{
	title_     = "ROM Disassembly";
	has_resize = true;
}

void CodeInspectorPanel::data_changed()
{
	scroll_to_adrs(data());	
}

void CodeInspectorPanel::scroll_to_line(int line) { target_line_ = line; }

void CodeInspectorPanel::scroll_to_adrs(int adrs) { scroll_to_line(ui_.disassembly().adrs_to_line(adrs)); }

void CodeInspectorPanel::do_draw_data()
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
		const char* items[]     = { "Hex", "Decimal", "Labels" };
		static int map[]        = { UI::kDisplayHex, UI::kDisplayDecimal, UI::kDisplayDisplacement };
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
		const char* items[]     = { "Hex", "Ascii", "Decimal", "Binary", "Octal" };
		static int map[]        = { UI::kDisplayHex, UI::kDisplayAscii, UI::kDisplayDecimal, UI::kDisplayBinary, UI::kDisplayOctal };
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
	float adrs_width  = 30 * char_width;
	float label_width = 21 * char_width;

	ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
	ImGuiListClipper clipper;
	// std::cout << "lines: " << ui_.lines().size() << std::endl;
	// std::cout << "line height: " << ImGui::GetTextLineHeightWithSpacing() << std::endl;
	// clipper.Begin(ui_.lines().size(), ImGui::GetTextLineHeightWithSpacing());
	clipper.Begin(ui_.lines().size(), ImGui::GetTextLineHeight());

	// test
	if (target_line_ != -1)
	{
		// float line_height = ImGui::GetTextLineHeightWithSpacing();
		float line_height = ImGui::GetTextLineHeight();
		target_line_ -= 5;
		if (target_line_ < 0)
			target_line_ = 0;
		float target_y    = target_line_ * line_height;
		ImGui::SetScrollY(target_y);
		target_line_ = -1;
	}

	while (clipper.Step())
	{
		for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
		{
			const auto& line = ui_.lines()[i];

			// Set background color for even lines
			if (i % 2 == 0)
			{
				paint_line( ImGui::GetColorU32(line_color) );
			}

			// Draw the address of the current line
			// 4 digits hexadecimal
			if (!line.is_empty())
			{

				//	If the line is selected, paint it
				if (line.start_adrs_<=data() && data()<=line.end_adrs_)
				{
					paint_line( ImGui::GetColorU32(bg_select_color) );
				}

				//  Address of the current instruction (column 1)
				auto display = ui_.address_display_style_;
				if (ui_.force_labels_)
					display = UI::kDisplayDisplacement;

				ui_.DrawAddress(line.start_adrs_, display, UI::kInteractNone);
				ui_.hoover(line.start_adrs_, tag + 0, ImGui::IsItemHovered());

				if (ImGui::IsItemClicked())
				{
					if (ImGui::GetMouseClickedCount(0) == 1)
					{
						ui_.update_adrs_panel(line.start_adrs_);
						ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs_));
						ui_.update_data_panel(line.start_adrs_);
					}

					if (ImGui::GetMouseClickedCount(0) == 2)
					{
						ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs_, ""));
					}
				}

				ImGui::SameLine();

				//  Bytes of the current instruction (column 2)
				display = ui_.bytes_display_style_;
				if (ui_.force_ascii_)
					display = UI::kDisplayAscii;

				for (int i = 0; i != line.byte_count(); i++)
				{
					ui_.DrawByte(line.get_byte(i), display, UI::kInteractNone, line.start_adrs_ + i);
					if (ImGui::IsItemClicked())
					{
							//	Update panels to go at this address
						if (ImGui::GetMouseClickedCount(0) == 1)
						{
							ui_.update_adrs_panel(line.start_adrs_ + i);
							ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs_ + i));
							ui_.update_data_panel(line.start_adrs_ + i);
						}
							//	Edition of label inside the list of bytes
						if (ImGui::GetMouseClickedCount(0) == 2)
						{
							ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs_+i, ""));
						}
					}
						//	Hoover to set the hoover address
					ui_.hoover(line.start_adrs_ + i, tag + 1, ImGui::IsItemHovered());

						//  The BYTE tooltip on bytes of the instruction/DB
					if (ImGui::IsItemHovered())
					{
						ImGui::BeginTooltip();
						auto v = ui_.explorer().rom().get(line.start_adrs_+i);
						ByteInspectorPanel::DisplayInstruction(ui_, ui_.explorer().cpu_info().instruction(v));
						ImGui::EndTooltip();
					}

					if (i==6)
					{
						ImGui::SameLine();
						ImGui::Text("...");
						break;
					}

				}
			}
			else
			{
				//  Label
				ImGui::Text("");
				ImGui::SameLine(label_width);
				if (ui_.is_hoover(line.start_adrs_))
				{
					UI::DrawSelectRect(line.spans()[0].content().c_str());
					ImGui::TextColored(std_select_color, "%s:", line.spans()[0].content().c_str());
				}
				else
					ImGui::TextColored(std_color, "%s:", line.spans()[0].content().c_str());
				ui_.hoover(line.start_adrs_, tag + 3, ImGui::IsItemHovered());

				//  Where the label was drawn
				ImVec2 line_start = ImGui::GetItemRectMin();
				ImVec2 line_end   = ImGui::GetItemRectMax();

#define SIZE 120
				//  Go to right end
				ImGui::SameLine(ImGui::GetWindowWidth() - SIZE); // Where we will draw
				auto pos = ImGui::GetCursorScreenPos();

				line_start.x = 0;
				line_end.x   = pos.x + SIZE;

				// Check if the mouse is hovering over the entire line
				if (ImGui::IsMouseHoveringRect(line_start, line_end))
				{
					// Add a close button
					std::string button_id = "X##" + std::to_string(line.start_adrs_);
					if (ImGui::SmallButton(button_id.c_str()))
					{
						ui_.remove_label_if_exists(line.spans()[0].content());
					}
				}

				// ImGui::SameLine();
			}

			ImGui::SameLine(adrs_width);

			// Instruction (Column 3)
			if (!line.is_empty())
				for (const auto& span : line.spans())
				{
					auto color   = std_color;
					bool is_mnem = false;
					bool is_adrs = false;
					switch (span.get_type())
					{
						case Span::kMnemonic:
							color   = mnemonic_color;
							is_mnem = true;
							break;
						case Span::kAddress:
							color   = adrs_color;
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
						ui_.DrawAddress(span.adrs(), UI::kDisplayDisplacement, UI::kInteractNone);
						ui_.hoover(span.adrs(), tag + 2, ImGui::IsItemHovered());
						if (ImGui::IsItemClicked())
						{
							ui_.inspect_adrs(span.adrs(), false);
							ui_.update_data_panel(span.adrs());
							ui_.update_code_panel(span.adrs());	//	We move within the code
						}
					}
					else
					{
						ImGui::TextColored(color, "%s", span.content().c_str());
						if (is_mnem && ImGui::IsItemHovered())
						{
							ImGui::BeginTooltip();
							auto v = ui_.explorer().rom().get(line.start_adrs_);
							ByteInspectorPanel::DisplayInstruction(ui_, ui_.explorer().cpu_info().instruction(v));
							ImGui::EndTooltip();
						}
						// if (is_adrs)
						// {
						//     ui_.hoover( span.adrs(), tag+1, ImGui::IsItemHovered() );
						// }
						// if (is_adrs && ImGui::IsItemClicked())
						// {
						//     ui_.inspect_adrs( span.adrs(), false );
						// }
					}
					ImGui::SameLine();
				}
			
			//	Comments (Column 4)
			const Comment *comment = ui_.explorer().annotations().comment_from_adrs(line.start_adrs_);
			if (comment)
			{
				ImGui::SameLine();
				ImGui::TextColored(comment_color, "; %s", comment->text().c_str());
			}
			else
			{
				//  Haaack
				ImGui::SameLine();
				ImGui::Text("                 ");
			}
			if (ImGui::IsItemClicked())
			{
				ui_.add_panel(std::make_unique<CommentEditModal>(ui_, line.start_adrs_));
			}

			// ImGui::Text("");

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
