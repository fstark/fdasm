#include "codeinspector.h"

#include "byteinspector.h"
#include "modal.h"
#include "ui.h"
#include "uicommon.h"

const int LABEL_COMMENT_START_COLUMN = 2;

const int ADRS_START_COLUMN = 0;
const int BYTES_START_COLUMN = 7;
// const int DELETE_LABEL_START_COLUMN = 20;
const int LABEL_START_COLUMN = 23;
const int INSTRUCTION_START_COLUMN = 32;
const int COMMENT_START_COLUMN = 55;

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

void CodeInspectorPanel::scroll_to_adrs(int adrs)
{
	if (ui_.explorer().rom().contains(adrs))
		scroll_to_line(ui_.disassembly().adrs_to_line(adrs));
}

void CodeInspectorPanel::paint_selection_if_needed( const Line &line )
{
	if (line.is_empty())
		return ; 		//	I don't understand why this is needed
	//	If the line is selected, paint it
	if (line.start_adrs()<=data() && data()<=line.end_adrs())
	{
		paint_line( ImGui::GetColorU32(ui_.preferences().get_color(Preferences::kLineSelectionColor)) );
	}
}

void CodeInspectorPanel::draw_line_adrs( const Line &line )
{
		//	We move to the instruction column
	ImGui::Text("");
	ImGui::SameLine(ADRS_START_COLUMN * char_width_,0);

	if (line.is_empty())
	{
		return ; 		//	I don't understand why this is needed
	}

	//  Address of the current instruction (column 1)
	auto display = address_display_style_;
	if (ui_.force_labels_)
		display = kDisplayDisplacement;

	ui_.DrawAddress(line.start_adrs(), display, UI::kInteractNone);
	ui_.hoover(line.start_adrs(), tag + 0, ImGui::IsItemHovered());

/*	if (ImGui::IsItemClicked())
	{
		if (ImGui::GetMouseClickedCount(0) == 1)
		{
			ui_.update_adrs_panel(line.start_adrs());
			ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs()));
			ui_.update_data_panel(line.start_adrs());
		}

		if (ImGui::GetMouseClickedCount(0) == 2)
		{
			ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs(), "",false));
		}
	}
*/
		ui_.show_context_menu(4, line.start_adrs(), line.start_adrs());
}

void CodeInspectorPanel::draw_line_bytes( const Line &line )
{
	ImGui::Text("");
	ImGui::SameLine(BYTES_START_COLUMN * char_width_,0);

		//  Bytes of the current instruction (column 2)
	auto display = bytes_display_style_;
	if (ui_.force_ascii_)
		display = kDisplayAscii;

	for (int i = 0; i != line.byte_count(); i++)
	{
		ui_.DrawByte(line.get_byte(i), display, UI::kInteractNone, line.start_adrs() + i);
		if (ImGui::IsItemClicked())
		{
				//	Update panels to go at this address
			if (ImGui::GetMouseClickedCount(0) == 1)
			{
				ui_.update_adrs_panel(line.start_adrs() + i);
				ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs() + i));
				ui_.update_data_panel(line.start_adrs() + i);
			}
				//	Edition of label inside the list of bytes
			if (ImGui::GetMouseClickedCount(0) == 2)
			{
				ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs()+i, "",false));
			}
		}
			//	Hoover to set the hoover address
		ui_.hoover(line.start_adrs() + i, tag + 1, ImGui::IsItemHovered());

			//  The BYTE tooltip on bytes of the instruction
		if (ImGui::IsItemHovered())
		{
			ImGui::BeginTooltip();
			auto v = ui_.explorer().rom().get(line.start_adrs()+i);
			ByteInspectorPanel::DisplayInstruction(ui_, ui_.explorer().cpu_info().instruction(v));
			ImGui::EndTooltip();
		}

		// if (i==6)
		// {
		// 	ImGui::SameLine();
		// 	ImGui::Text("...");
		// 	ImGui::SameLine(0,0);
		// 	break;
		// }
	}
}


void CodeInspectorPanel::will_visit(const Line& line)
{
	if (nested_==0)
	{
			//	We select the line
		paint_selection_if_needed( line );

			//	We print the address if needed
		draw_line_adrs( line );
		ImGui::SameLine(0,0);

			//	We print the bytes
		draw_line_bytes( line );

			//	We move to the instruction column
		ImGui::Text("");
		ImGui::SameLine(INSTRUCTION_START_COLUMN * char_width_,0);
	}
	else
	{
		ImGui::Text("");
		ImGui::SameLine(8 * char_width_,0);
	}
}

void CodeInspectorPanel::did_visit(const Line& line)
{
	if (line.is_empty())
	{
		return ; 		//	I don't understand why this is needed
	}

	ImGui::SameLine(0,0);
	ImGui::Text("");
	if (nested_==0)
		ImGui::SameLine(COMMENT_START_COLUMN * char_width_,0);
	else
		ImGui::SameLine((COMMENT_START_COLUMN-INSTRUCTION_START_COLUMN+4) * char_width_,0);

	const Comment *comment = ui_.explorer().annotations().comment_from_adrs(line.start_adrs());
	if (comment)
	{

		ui_.draw_comment( line.start_adrs(), comment->comment_text() );
	}
	else
	{
		//  #### Haaack just for the click. This is bad.
		ImGui::Text("                 ");
	}
	// if (ImGui::IsItemClicked())
	// {
	// 	ui_.add_panel(std::make_unique<CommentEditModal>(ui_, line.start_adrs()));
	// }
}

void CodeInspectorPanel::visit(const OrgDirectiveLine& line)
{
	ImGui::Text("ORG %04XH", line.adrs());
}

void CodeInspectorPanel::visit(const DBDirectiveLine& line)
{
	auto display = bytes_display_style_;
	if (ui_.force_ascii_)
		display = kDisplayAscii;

	ImGui::Text("DB ");
	ImGui::SameLine(0,0);
	auto data = line.data();
	auto adrs = line.start_adrs();
	const char *sep = "";
	for (auto byte : data)
	{
		ImGui::Text("%s", sep);
		ImGui::SameLine(0,0);
		sep = ",";
		ui_.DrawByte(byte, static_cast<eDisplayStyle>(display | kDisplayStyleASM), UI::kInteractNone, adrs);
		ui_.hoover(adrs, tag + 65, ImGui::IsItemHovered());
		if (ImGui::IsItemClicked())
		{
			ui_.update_byte_panel(byte);
		}
		ImGui::SameLine(0,0);
		adrs++;
	}
	ImGui::Text("");
}

void CodeInspectorPanel::visit(const DWDirectiveLine& line)
{
	auto display = kDisplayDisplacement;
	if (ui_.force_labels_)
		display = kDisplayHex;

	ImGui::Text("DW ");
	ImGui::SameLine(0,0);
	auto data = line.data();
	const char *sep = "";
	for (auto word : data)
	{
		ImGui::Text("%s", sep);
		ImGui::SameLine(0,0);
		sep = ",";
		ui_.DrawAddress(word, static_cast<eDisplayStyle>(display | kDisplayStyleASM), UI::kInteractNone);
		ui_.hoover(word, tag + 73, ImGui::IsItemHovered());
		if (ImGui::IsItemClicked())
		{
			ui_.inspect_adrs(word, false);
			ui_.update_data_panel(word);
			ui_.update_code_panel(word);	//	We move within the code
		}
		ImGui::SameLine(0,0);
	}
	ImGui::Text("");
}

void CodeInspectorPanel::visit(const DSDirectiveLine& line)
{
	ImGui::Text("DB ");
	ImGui::SameLine(0,0);
	ImGui::Text("\"");
	ImGui::SameLine(0,0);
	ImGui::TextColored(ui_.preferences().get_color(Preferences::kStringColor),"%s", line.data().c_str());
	ImGui::SameLine(0,0);
	ImGui::Text("\"");
}

void CodeInspectorPanel::visit(const InstructionLine& line)
{
		//	#### This should also be in the instruction itself, via "hints"
	auto display = address_display_style_;
	if (ui_.force_ascii_)
		display = kDisplayAscii;

	auto display_adrs = kDisplayDisplacement;
	if (ui_.force_labels_)
		display_adrs = kDisplayHex;

	auto inst = line.instruction();
	ImGui::TextColored( ui_.preferences().get_color(Preferences::kOpCodeColor), "%s", inst.short_mnemonic().c_str() );

	//	Instruction tooltip
	if (ImGui::IsItemHovered())
	{
		ImGui::BeginTooltip();
		auto v = ui_.explorer().rom().get(line.start_adrs());
		ByteInspectorPanel::DisplayInstruction(ui_, ui_.explorer().cpu_info().instruction(v));
		ImGui::EndTooltip();
	}

	if (inst.has_d8())
	{
		ImGui::SameLine(0,0);
		if (inst.is_io_read() || inst.is_io_write())
		{
			ui_.DrawIOPort(line.byte(), static_cast<eDisplayStyle>(kDisplayLabel | kDisplayStyleASM));
			ui_.hoover_io(line.byte(), 0, ImGui::IsItemHovered());
		}
		else
		{
			ui_.DrawByte(line.byte(), static_cast<eDisplayStyle>(display | kDisplayStyleASM), UI::kInteractNone, line.start_adrs() + 1);
			ui_.hoover(line.start_adrs() + 1, tag + 64, ImGui::IsItemHovered());
		}
		if (ImGui::IsItemClicked())
		{
			ui_.update_byte_panel(line.byte());
			if (inst.is_io_read() || inst.is_io_write())
			{
				ui_.update_io_panel(line.byte());
			}
		}
		ImGui::Text("");
	}
	if (inst.has_d16())
	{
		auto adrs = line.word();
		ImGui::SameLine(0,0);

		ui_.DrawAddress(adrs, static_cast<eDisplayStyle>(display_adrs|kDisplayStyleASM), UI::kInteractNone);
		ui_.hoover(adrs, tag + 2, ImGui::IsItemHovered());
		ui_.show_context_menu(1, line.start_adrs(), adrs);
	}
	if (inst.has_adrs())
	{
		auto adrs = line.word();
		ImGui::SameLine(0,0);

		ui_.DrawAddress(adrs, static_cast<eDisplayStyle>(display_adrs|kDisplayStyleASM), UI::kInteractNone);
		ui_.hoover(adrs, tag + 3, ImGui::IsItemHovered());
		ui_.show_context_menu(2,line.start_adrs(), adrs);

		//	Special case for JUMP instructions
		if (inst.is_jump() && ImGui::IsItemHovered())
		{
			ImGui::BeginTooltip();
			code_preview( adrs );
			ImGui::EndTooltip();
		}
	}
}

void CodeInspectorPanel::code_preview( adrs_t adrs, int count )
{
	//	### Bad: this has to be calculated for the tool-tip use case
	char_width_ = ImGui::CalcTextSize("A").x;

	nested_++;

	//	Find line for adrs
	//	And we skip back all the labels, comment and blank lines
	auto line = ui_.disassembly().adrs_to_line(adrs);
	if (line>0)
	{
		line--;
		Line *l = ui_.lines()[line];
		while (dynamic_cast<const LabelLine*>(l) != nullptr || dynamic_cast<const CommentLine*>(l) != nullptr || dynamic_cast<const BlankLine*>(l) != nullptr)
		{
			if (line==0)
			{
				line--;
				break;
			}
			line--;
			l = ui_.lines()[line];
		}
		line++;
	}

	//	We draw all lines until we have 8 instructions
	int drawn = 0;
	while (1)
	{
		if (line>=ui_.lines().size())
			break;
		Line *l = ui_.lines()[line];
		if (l)
		{
				//	We skip blank lines
			if (dynamic_cast<const BlankLine*>(l) == nullptr)
			{
				paint_selection_if_needed( *l );
				draw_line_adrs( *l );
				ImGui::SameLine();
				l->visit(*this);
			}

				//	We count the number of instruction lines
			if (dynamic_cast<const InstructionLine*>(l) != nullptr)
			{
				drawn++;
				if (drawn>=count)
					break;
			}
		}
		line++;
	}

	nested_--;
}

void CodeInspectorPanel::visit(const CommentLine& line)
{
	ImGui::SameLine(LABEL_COMMENT_START_COLUMN * char_width_,0);

	// ImGui::TextColored(ui_.preferences().get_color(Preferences::kCommentColor), ";");
	// ImGui::SameLine();
	// ImGui::TextColored(ui_.preferences().get_color(Preferences::kCommentColor), "%s", line.comment().c_str());

	ui_.draw_comment( line.start_adrs(), line.comment() );

	// if (ImGui::IsItemClicked())
	// {
	// 	ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs(), "",false));
	// }
}

void CodeInspectorPanel::visit(const LabelLine& line)
{
	//  Label
	ImGui::Text("");
	// if (nested_==0)
	// 	ImGui::SameLine(DELETE_LABEL_START_COLUMN * char_width_,0);
	// else
		ImGui::SameLine(0.01 * char_width_,0);

	if (nested_==0)
	{
		// std::string button_id = ICON_FA_CIRCLE_XMARK"##" + std::to_string(line.start_adrs());
		// if (is_hovering_line_ && small_icon_button(button_id.c_str()))
		// {
		// 	ui_.remove_label_if_exists(line.label().name());
		// }
		ImGui::SameLine(LABEL_START_COLUMN * char_width_,0);
	}

	if (ui_.is_hoover(line.start_adrs()))
	{
		UI::DrawSelectRect(line.label().name().c_str());
		ImGui::TextColored(ui_.preferences().get_color(Preferences::kSelectedLabelColor), "%s:", line.label().name().c_str());
	}
	else
		ImGui::TextColored(ui_.preferences().get_color(Preferences::kLabelColor), "%s:", line.label().name().c_str());
	ui_.hoover(line.start_adrs(), tag + 3, ImGui::IsItemHovered());
	ui_.show_context_menu(3,line.start_adrs(), line.start_adrs());
}

void CodeInspectorPanel::visit(const BlankLine& )
{
	ImGui::Text("");
}

void CodeInspectorPanel::do_draw_data()
{
	ImGui::SameLine();

	ImGui::PushItemWidth(80);

	{
		ImGui::Text("Adrs:");
		ImGui::SameLine();

		const char* items[]     = { "Hex", "Decimal", "Labels" };
		static int map[]        = { kDisplayHex, kDisplayDecimal, kDisplayDisplacement };
		static int item_current = 0;
		// find the current item from address_display_style_ (#### Can do C++ way)
		for (int i = 0; i < IM_ARRAYSIZE(map); i++)
		{
			if (map[i] == address_display_style_)
			{
				item_current = i;
				break;
			}
		}
		ImGui::Combo("##AdrsCol1", &item_current, items, IM_ARRAYSIZE(items));
		// Stores new display style
		address_display_style_ = (eDisplayStyle)map[item_current];
	}
	ImGui::SameLine();
	{
		ImGui::Text("Data:");
		ImGui::SameLine();

		const char* items[]     = { "Hex", "Ascii", "Decimal", "Binary", "Octal" };
		static int map[]        = { kDisplayHex, kDisplayAscii, kDisplayDecimal, kDisplayBinary, kDisplayOctal };
		static int item_current = 0;
		for (int i = 0; i < IM_ARRAYSIZE(map); i++)
		{
			if (map[i] == bytes_display_style_)
			{
				item_current = i;
				break;
			}
		}
		ImGui::Combo("##AdrsCol2", &item_current, items, IM_ARRAYSIZE(items));
		// Stores new display style
		bytes_display_style_ = (eDisplayStyle)map[item_current];
	}
	ImGui::PopItemWidth();

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
			is_hovering_line_ = is_hover_line();	//	True if mouse over current line

			const auto& line = *ui_.lines()[i];

			// Set background color for even lines
			if (i % 2 == 0)
			{
				if (dynamic_cast<const BlankLine*>(&line) == nullptr
				&& dynamic_cast<const CommentLine*>(&line) == nullptr)
					paint_line( ImGui::GetColorU32(line_color) );
			}

			line.visit(*this);

#if 0
			// Draw the address of the current line
			// 4 digits hexadecimal
			if (!line.is_empty())
			{

				//	If the line is selected, paint it
				if (line.start_adrs()<=data() && data()<=line.end_adrs())
				{
					paint_line( ImGui::GetColorU32(bg_select_color) );
				}

				//  Address of the current instruction (column 1)
				auto display = address_display_style_;
				if (ui_.force_labels_)
					display = kDisplayDisplacement;

				ui_.DrawAddress(line.start_adrs(), display, UI::kInteractNone);
				ui_.hoover(line.start_adrs(), tag + 0, ImGui::IsItemHovered());

				if (ImGui::IsItemClicked())
				{
					if (ImGui::GetMouseClickedCount(0) == 1)
					{
						ui_.update_adrs_panel(line.start_adrs());
						ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs()));
						ui_.update_data_panel(line.start_adrs());
					}

					if (ImGui::GetMouseClickedCount(0) == 2)
					{
						ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs(), "",false));
					}
				}
DONE TO HERE

				ImGui::SameLine();

				//  Bytes of the current instruction (column 2)
				display = bytes_display_style_;
				if (ui_.force_ascii_)
					display = kDisplayAscii;

				for (int i = 0; i != line.byte_count(); i++)
				{
					ui_.DrawByte(line.get_byte(i), display, UI::kInteractNone, line.start_adrs() + i);
					if (ImGui::IsItemClicked())
					{
							//	Update panels to go at this address
						if (ImGui::GetMouseClickedCount(0) == 1)
						{
							ui_.update_adrs_panel(line.start_adrs() + i);
							ui_.update_byte_panel(ui_.explorer().rom().get(line.start_adrs() + i));
							ui_.update_data_panel(line.start_adrs() + i);
						}
							//	Edition of label inside the list of bytes
						if (ImGui::GetMouseClickedCount(0) == 2)
						{
							ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs()+i, "",false));
						}
					}
						//	Hoover to set the hoover address
					ui_.hoover(line.start_adrs() + i, tag + 1, ImGui::IsItemHovered());

						//  The BYTE tooltip on bytes of the instruction/DB
					if (ImGui::IsItemHovered())
					{
						ImGui::BeginTooltip();
						auto v = ui_.explorer().rom().get(line.start_adrs()+i);
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
DONE
				skip_adrs_comment = true;
				//  Label
				ImGui::Text("");
				ImGui::SameLine(close_button_x);

				std::string button_id = ICON_FA_CIRCLE_XMARK"##" + std::to_string(line.start_adrs());
				if (is_hovering_line && small_icon_button(button_id.c_str()))
				{
					ui_.remove_label_if_exists(line.spans()[0].content());
				}
				ImGui::SameLine(label_width);

				if (ui_.is_hoover(line.start_adrs()))
				{
					UI::DrawSelectRect(line.spans()[0].content().c_str());
					ImGui::TextColored(std_select_color, "%s:", line.spans()[0].content().c_str());
				}
				else
					ImGui::TextColored(std_color, "%s:", line.spans()[0].content().c_str());
				ui_.hoover(line.start_adrs(), tag + 3, ImGui::IsItemHovered());

				if (ImGui::IsItemClicked())
				{
					ui_.add_panel(std::make_unique<LabelEditModal>(ui_, line.start_adrs(), "",false));
				}
			}

			ImGui::SameLine(adrs_width);

			// Instruction (Column 3)
			if (!line.is_empty())
			{
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
							color = operand_color;
							break;
					}

					if (is_adrs)
					{
						ui_.DrawAddress(span.adrs(), kDisplayDisplacement, UI::kInteractNone);
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
							auto v = ui_.explorer().rom().get(line.start_adrs());
							ByteInspectorPanel::DisplayInstruction(ui_, ui_.explorer().cpu_info().instruction(v));
							ImGui::EndTooltip();
						}
						if (is_mnem)
						{
							ImGui::SameLine(0, 0);
							ImGui::Text(" ");
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
					ImGui::SameLine(0,0);
				}
			}

			if (!skip_adrs_comment)
			{
				//	Comments (Column 4)
				const Comment *comment = ui_.explorer().annotations().comment_from_adrs(line.start_adrs());
				if (comment)
				{
					ImGui::SameLine(350);
					ImGui::TextColored(comment_color, "; %s", comment->text().c_str());
				}
				else
				{
					//  Haaack
					ImGui::SameLine(350);
					ImGui::Text("                 ");
				}
				if (ImGui::IsItemClicked())
				{
					ui_.add_panel(std::make_unique<CommentEditModal>(ui_, line.start_adrs()));
				}
			}
			else
			{
				ImGui::Text("");
			}
#endif
		}
	}
	clipper.End();
	ImGui::EndChild();
}
