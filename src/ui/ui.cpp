#include "ui.h"

#include "annotations.h"
#include "disassembler.h"
#include "explorer.h"
#include "label.h"
#include <memory>
#include <stdio.h>

#include "uicommon.h"

#include "byteinspector.h"
#include "codeinspector.h"
#include "datainspector.h"
#include "adrsinspector.h"
#include "ioinspector.h"

#include "labelspanel.h"
#include "iospanel.h"
#include "preferences.h"

#include <algorithm>

//move to uicommon.cpp
void UnderlineTextColored(const ImVec4& color, const char* text)
{
    // Get the current window's draw list
    ImDrawList* draw_list = ImGui::GetWindowDrawList();

    // Get the position and size of the text
    ImVec2 text_pos = ImGui::GetCursorScreenPos();
    ImVec2 text_size = ImGui::CalcTextSize(text);

    // Draw the text
    ImGui::TextColored(color, "%s", text);

    // Draw the underline
    ImVec2 line_start = ImVec2(text_pos.x, text_pos.y + text_size.y);
    ImVec2 line_end = ImVec2(text_pos.x + text_size.x, text_pos.y + text_size.y);
    draw_list->AddLine(line_start, line_end, ImGui::GetColorU32(ImGuiCol_Text));
}




UI::UI(Explorer& explorer)
	: explorer_{ explorer }
{
	preferences_ = std::make_unique<Preferences>( *this );

	//  We disassemble the code
	changed();

	init_imgui();

	//	We create the main panels
	code_inspector_       = std::make_unique<CodeInspectorPanel>(*this, explorer_.rom().load_adrs());
	code_inspector_->set_unique();
	data_inspector_panel_ = std::make_unique<DataInspectorPanel>(*this);
	data_inspector_panel_->set_unique();
	adrs_inspector_ = std::make_unique<AdrsInspectorPanel>(*this, explorer_.rom().load_adrs());
	adrs_inspector_->set_unique();
	byte_inspector_ = std::make_unique<ByteInspectorPanel>( *this, explorer_.rom().get(explorer_.rom().load_adrs()) );
	byte_inspector_->set_unique();
	labels_panel_ = std::make_unique<LabelsPanel>(*this);
	labels_panel_->set_unique();
	ios_panel_ = std::make_unique<IOsPanel>(*this);
	ios_panel_->set_unique();
	io_inspector_panel_ = std::make_unique<IOInspectorPanel>(*this,0);
	io_inspector_panel_->set_unique();
}

UI::~UI()
{
	shutdown_imgui();
}

void UI::close_panels()
{
	panels_.erase(std::remove_if(panels_.begin(), panels_.end(), [](const std::unique_ptr<Panel>& p)
						{ return !p->is_open(); }),
		panels_.end());
}

void UI::add_panel(std::unique_ptr<Panel> panel)
{
	panels_.push_back(std::move(panel));
}

void UI::update_adrs_panel( adrs_t adrs )
{
	adrs_inspector_->set_data(adrs);
}

void UI::update_byte_panel( uint8_t b )
{
	byte_inspector_->set_data(b);
}

void UI::update_io_panel( uint8_t b )
{
	io_inspector_panel_->set_data(b);
}

void UI::update_code_panel( adrs_t adrs )
{
	code_inspector_->set_data(adrs);
}

void UI::update_data_panel( adrs_t adrs )
{
	data_inspector_panel_->set_data(adrs);
}

void UI::new_disassembly_panel( adrs_t adrs )
{
	auto cip = std::make_unique<CodeInspectorPanel>(*this, adrs);
	cip->scroll_to_adrs(adrs);
	panels_.push_back(std::move(cip));
	panels_.back()->set_closable(true);
}

void UI::inspect_adrs(adrs_t adrs, bool /* hoover */)
{
	update_adrs_panel( adrs );

	if (link_)
		new_disassembly_panel( adrs );

	// if (!link_)
	// {
	// 	panels_.push_back(std::make_unique<AdrsInspectorPanel>(*this, adrs));
	// 	panels_.back()->set_closable(true);
	// }
	// else
	// {
	// 	new_disassembly_panel( adrs );
	// }
}

#include "resmanager.h"

void UI::init_imgui()
{
	// Initialize SDL
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_GAMECONTROLLER | IMG_INIT_PNG) != 0)
	{
		printf("Error: %s\n", SDL_GetError());
		throw std::runtime_error("Failed to initialize SDL");
	}

	const char* glsl_version = "#version 150";
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG); // Always required on Mac
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);

	SDL_SetHint(SDL_HINT_IME_SHOW_UI, "1");

	// Create window with graphics context
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
	SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
	SDL_WindowFlags window_flags = (SDL_WindowFlags)(SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI); // NOLINT
	window                       = SDL_CreateWindow("8085 Disassembler", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1280, 720, window_flags);
	gl_context                   = SDL_GL_CreateContext(window);
	SDL_GL_MakeCurrent(window, gl_context);
	SDL_GL_SetSwapInterval(1); // Enable vsync

	// Setup Dear ImGui context
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO();
	(void)io;
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard; // Enable Keyboard Controls
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;  // Enable Gamepad Controls

	// Setup Dear ImGui style
	ImGui::StyleColorsDark();
	//ImGui::StyleColorsLight();

	// Setup Platform/Renderer backends
	ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
	ImGui_ImplOpenGL3_Init(glsl_version);

	// Initialize ImGui
	ImGui::CreateContext();

	// Set the font size
	// io.Fonts->AddFontFromFileTTF("src/external/imgui/misc/fonts/ProggyClean.ttf", 13.0f);
	io.Fonts->AddFontFromFileTTF(ResourceManager::default_manager().path_for_resource("ProggyClean.ttf").c_str(), 13.0f);

	ImFontConfig config;
	config.MergeMode = true;
	config.GlyphMinAdvanceX = 13.0f; // Use if you want to make the icon monospaced
	static const ImWchar icon_ranges[] = { ICON_MIN_FA, ICON_MAX_FA, 0 };
	// io.Fonts->AddFontFromFileTTF("src/fontawesome-free-solid-900.otf", 12.0f, &config, icon_ranges);
	io.Fonts->AddFontFromFileTTF(ResourceManager::default_manager().path_for_resource("fontawesome-free-solid-900.otf").c_str(), 12.0f, &config, icon_ranges);

	tiny_font_  = io.Fonts->AddFontFromFileTTF(ResourceManager::default_manager().path_for_resource("ProggyClean.ttf").c_str(), 26.0f / 3);
	large_font_ = io.Fonts->AddFontFromFileTTF(ResourceManager::default_manager().path_for_resource("ProggyClean.ttf").c_str(), 26.0f);
}

void UI::replace_label(const std::string& label, adrs_t adrs, Annotations::RegionType type, const std::string &comment)
{
	//  We remove existing lavel at this address
	Label* lbl = explorer_.annotations().label_from_adrs(adrs);
	if (lbl)
	{
		explorer_.annotations().remove_label_if_exists(lbl->name());
	}
	//  If name is not empty, we add a new label
	if (!label.empty())
	{
		explorer_.annotations().remove_label_if_exists(label);
		explorer_.annotations().add_label(label, adrs, type, comment);
	}
	//  We rebuild the disassembly
	changed();
	(void)explorer_.annotations().write_annotations();
}


// void UI::DrawAddress( adrs_t adrs )
// {
//     //  Draw the Address for the line
//     char buffer[5];
//     snprintf( buffer, 5, "%04x", adrs );
//     ImGui::TextColored(adrs_color, "%s", buffer ); // Display address
//     if (ImGui::IsItemHovered())
//     {
//         inspect_adrs( adrs, true );
//     }
//     if (ImGui::IsItemClicked())
//     {
//         inspect_adrs( adrs, false );
//     }
//     ImGui::SameLine();
// }

void UI::DrawSelectRect(const char* buffer, ImU32 color )
{
	ImVec2 text_size  = ImGui::CalcTextSize(buffer);
	ImVec2 cursor_pos = ImGui::GetCursorScreenPos();
	ImGui::GetWindowDrawList()->AddRectFilled(cursor_pos, ImVec2(cursor_pos.x + text_size.x, cursor_pos.y + text_size.y), color);
}

void UI::DrawSelectRect(const char* buffer, ImVec4 color )
{
	DrawSelectRect( buffer, ImGui::GetColorU32(color));
}

void UI::DrawSelectRect(const char* buffer)
{
	DrawSelectRect( buffer, select_color);
}

//  Draws an address with specific style
//  and handle interactions
void UI::DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions /* interactions */, const ImVec4& /* color */)
{
	char buffer[256];

	//	Find number of call to this address
	size_t count = explorer().xrefs().xrefs_to_count(adrs);
	int count_char = ' ';

	if (count>0 && count<10)
		count_char = '0' + count;
	else if (count>=10)
		count_char = '*';

	//  Default is hexadecimal
	if (display_style&kDisplayStyleASM)
		snprintf(buffer, 256, "%04XH", adrs);
	else
		snprintf(buffer, 256, "%04x %c ", adrs, count_char);

	switch (display_style)
	{
		case kDisplayHex:
		case kDisplayHex|kDisplayStyleASM:
			break;
		case kDisplayDecimal:
		case kDisplayDecimal|kDisplayStyleASM:
			snprintf(buffer, 256, "%5d", adrs);
			break;
		case kDisplayLabel:
		case kDisplayLabel|kDisplayStyleASM:
		{
			auto lbl = explorer().annotations().label_from_adrs(adrs);
			if (lbl)
				snprintf(buffer, 256, "%s", lbl->name().c_str());
		}
		break;
		case kDisplayDisplacement:
		case kDisplayDisplacement|kDisplayStyleASM:
		{
			auto lbl = explorer().annotations().label_before_adrs(adrs, 99);
			if (!lbl)
				break;
			else if (lbl->start_adrs() == adrs)
				snprintf(buffer, 256, "%s", lbl->name().c_str());
			else
				snprintf(buffer, 256, "%s+%d", lbl->name().c_str(), adrs - lbl->start_adrs());
		}
		break;
		default:
			snprintf(buffer, 256, "????");
			break;
	}

	if (is_hoover(adrs))
	{
		DrawSelectRect(buffer);
	}

	// ImGui::PushID(adrs);

	ImGui::TextColored(address_color(adrs), "%s", buffer); // Display address

	// ImGui::Text("LOL"); // Display address

	// ImGui::PopID();
}

void UI::DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions /* interactions */ )
{
	DrawAddress(adrs, display_style, kInteractNone, adrs_color);
}

void UI::DrawIOPort(uint8_t io_adrs, eDisplayStyle display_style )
{
	char buffer[256];

	display_style = static_cast<eDisplayStyle>(display_style & ~kDisplayStyleASM);

	if (display_style==kDisplayLabel)
	{
		auto port = explorer().annotations().io_list().get_port(io_adrs);
		if (port.name().empty())
		{
			snprintf(buffer, 256, "%02XH", io_adrs);
		}
		else
		{
			snprintf(buffer, 256, "%s", port.name().c_str());
		}
	}
	else /* if (display_style==kDisplayHex) */
	{
		snprintf(buffer, 256, "%02XH", io_adrs);
	}
	if (is_hoover_io(io_adrs))
	{
		DrawSelectRect(buffer);
	}

	ImGui::TextColored(preferences().get_color(Preferences::kIOColor), "%s",buffer);

	ImGui::SameLine(0,0);
}

void UI::DrawByte(uint8_t byte, eDisplayStyle display_style, eInteractions /* interactions */, adrs_t adrs)
{
	char buffer[256];

	format_byte( buffer, byte, display_style );

	if (is_hoover(adrs))
	{
		UI::DrawSelectRect(buffer);
		ImGui::TextColored(preferences().get_color(Preferences::kByteSelectColor), "%s", buffer);
	}
	else
		ImGui::TextColored(preferences().get_color(Preferences::kByteColor), "%s", buffer);

	ImGui::SameLine();
}

void UI::draw_comment( const CommentText &comment, bool semicolon )
{
	draw_comment( INVALID_ADRS, comment, semicolon );
}


void UI::draw_comment( adrs_t from_adrs, const CommentText &comment, bool semicolon )
{
	// ImGui::BeginGroup();

	const std::vector<std::string> &chunks = comment.chunks();

	if (semicolon)
		ImGui::TextColored(preferences().get_color(Preferences::kCommentColor), "; ");
	else
		ImGui::Text("");

	bool even = true;
	int chunk_id = 0;
	for (auto &chunk: chunks)
	{
		if (even)
		{
			ImGui::SameLine(0,0);
			ImGui::TextColored(preferences().get_color(Preferences::kCommentColor), "%s", chunk.c_str());
			show_context_menu( 200+chunk_id, from_adrs, from_adrs, (void *)&comment );
		}
		else
		{
			ImGui::SameLine(0,0);
			UnderlineTextColored( preferences().get_color(Preferences::kCommentColor), chunk.c_str() );

			//	Lookup address for the chunk
			Label *l = explorer().annotations().label_from_name(chunk);
			if (l)
			{
				show_context_menu( 100+chunk_id, from_adrs, l->start_adrs() );
			}
			else
			{
				//	Maybe an hex address?
				const char *p = chunk.c_str();
				if (strlen(p)==5 && p[4]=='H')
				{
					unsigned int v;
					if (sscanf( p, "%04XH", &v )==1)
						show_context_menu( 100+chunk_id, from_adrs, (adrs_t)v );
				}
			}
		}

		even = !even;
		chunk_id++;
	}

	// ImGui::EndGroup();
}

#include "modal.h"

void UI::show_context_menu( int tag, adrs_t from_adrs, adrs_t to_adrs, const void *id )
{
		// Add right-click context menu
	char buffer[256];
	if (!id)
		snprintf(buffer, 256, "##%04X-%04X-%d", from_adrs, to_adrs, tag);
	else
		snprintf(buffer, 256, "##%p-%d", id, tag);

	if (ImGui::IsItemClicked(ImGuiMouseButton_Left)) // Check for left-click
	{
printf( "CONTEXT!\n");

	    ImGui::OpenPopup(buffer); // Open the popup
	}

	if (to_adrs!=INVALID_ADRS && ImGui::BeginPopup(buffer))
	{
		if (from_adrs!=to_adrs && ImGui::MenuItem("Go to"))
		{
			update_code_panel(to_adrs);	//	We move within the code
		}

		if (ImGui::MenuItem("Show in address inspector"))
		{
			update_adrs_panel(to_adrs);
		}

		if (ImGui::MenuItem("Show in data inspector"))
		{
			update_data_panel(to_adrs);
		}

		if (ImGui::MenuItem("Open code in new Window"))
		{
			new_disassembly_panel( to_adrs );
		}

		Label *l = explorer().annotations().label_from_adrs(to_adrs);
		if (l)
		{
			if (ImGui::MenuItem("Label..."))
			{
				add_panel(std::make_unique<LabelEditModal>(*this, to_adrs, l->name(),true));
			}
		}
		else
		{
			if (ImGui::MenuItem("Label..."))
			{
				add_panel(std::make_unique<LabelEditModal>(*this, to_adrs, "",true));
			}
		}

		if (from_adrs!=INVALID_ADRS && ImGui::MenuItem("Edit line comment..."))
				add_panel(std::make_unique<CommentEditModal>(*this, from_adrs));

		if (from_adrs!=to_adrs && ImGui::MenuItem("Edit target comment..."))
				add_panel(std::make_unique<CommentEditModal>(*this, to_adrs));

		ImGui::EndPopup();
	}
}


void UI::run()
{
	int done = 0;

	ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_DockingEnable; // Enable docking

	while (!done)
	{
		SDL_Event event;
		while (SDL_PollEvent(&event))
		{
			ImGui_ImplSDL2_ProcessEvent(&event);
			if (event.type == SDL_QUIT)
				done = true;
			if (event.type == SDL_WINDOWEVENT && event.window.event == SDL_WINDOWEVENT_CLOSE && event.window.windowID == SDL_GetWindowID(window))
				done = true;
			if (event.type == SDL_KEYDOWN && event.key.keysym.sym == 'a')
				force_ascii_ = true;
			if (event.type == SDL_KEYUP && event.key.keysym.sym == 'a')
				force_ascii_ = false;
			if (event.type == SDL_KEYDOWN && event.key.keysym.sym == 'l')
				force_labels_ = true;
			if (event.type == SDL_KEYUP && event.key.keysym.sym == 'l')
				force_labels_ = false;
			//  Testing is "Ctrl" is pressed (alone)
			if (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_LALT)
			{
				std::clog << "LINKS" << std::endl;
				link_ = true;
			}
			if (event.type == SDL_KEYUP && event.key.keysym.sym == SDLK_LALT)
			{
				std::clog << "NO LINKS" << std::endl;
				link_ = false;
			}
		}

		ImGui_ImplOpenGL3_NewFrame();
		ImGui_ImplSDL2_NewFrame();

		hoover_start_frame();

		ImGui::NewFrame();
        // Create a docking space
        ImGui::DockSpaceOverViewport(0,ImGui::GetMainViewport());

		//  The main window
		code_inspector_->draw();

		// Show demo ImgUI window
		ImGui::ShowDemoWindow();

		//  Preferences
		preferences_->draw();

		//  Byte info if needed
		if (byte_inspector_)
			byte_inspector_->draw();

		//  Address info if needed
		if (adrs_inspector_)
			adrs_inspector_->draw();

		//  Data inspector
		if (data_inspector_panel_)
			data_inspector_panel_->draw();

		//	Labels
		if (labels_panel_)
			labels_panel_->draw();

		//	IO Ports
		if (ios_panel_)
			ios_panel_->draw();

		//	IO
		if (io_inspector_panel_)
			io_inspector_panel_->draw();

		std::vector<Panel*> to_draw;
		for (const auto& p : panels_)
			to_draw.push_back(p.get());

		for (const auto p : to_draw)
			p->draw();

		//  Remove all panels that are not open
		close_panels();

		// Rendering
		ImGui::Render();
		glViewport(0, 0, (int)io.DisplaySize.x, (int)io.DisplaySize.y);
		// glClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
		glClearColor(1, 1, 1, 1);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
		SDL_GL_SwapWindow(window);

		// Execute actions
		if (remove_label_ != "")
		{
			explorer_.annotations().remove_label_if_exists(remove_label_);
			remove_label_ = "";
			changed();
			(void)explorer_.annotations().write_annotations();
		}
	}
}


void UI::shutdown_imgui()
{
	// Cleanup
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplSDL2_Shutdown();
	ImGui::DestroyContext();

	SDL_GL_DeleteContext(gl_context);
	SDL_DestroyWindow(window);
	SDL_Quit();
}

ImVec4 UI::address_color(adrs_t adrs) const
{
	typedef enum eAddrsType
	{
		kAdrsHex,
		kAdrsGlobal,
		kAdrsLocal
	} eAdrsType;

	eAdrsType adrs_type = kAdrsHex;

	if (explorer_.annotations().label_from_adrs(adrs))
		adrs_type = kAdrsGlobal;

	bool is_rom = explorer_.rom().contains(adrs);

	bool is_data = true;
	if (explorer_.annotations().get_region_type(adrs)==Annotations::kCODE)
		is_data = false;

	//  We set the color according to the address type
	return preferences_->get_color( adrs_type*4+is_rom*2+is_data );
}

void UI::changed()
{

	disassembly_ = explorer_.disassembler()->disassemble();
	explorer_.asmgenerator().generate( lines(), explorer_.annotations() );
}

