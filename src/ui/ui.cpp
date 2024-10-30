#include "ui.h"

#include "annotations.h"
#include "disassembler.h"
#include "explorer.h"
#include "label.h"
#include <memory>
#include <stdio.h>

#include "byteinspector.h"
#include "uicommon.h"

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
    //  #### TODO: Make this configurable/smarter
	io.Fonts->AddFontFromFileTTF("src/external/imgui/misc/fonts/ProggyClean.ttf", 13.0f);
	tiny_font_  = io.Fonts->AddFontFromFileTTF("src/external/imgui/misc/fonts/ProggyClean.ttf", 26.0f / 3);
	large_font_ = io.Fonts->AddFontFromFileTTF("src/external/imgui/misc/fonts/ProggyClean.ttf", 26.0f);
}

void UI::replace_label(const std::string& label, adrs_t adrs, Annotations::RegionType type)
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
		explorer_.annotations().add_label(label, adrs, type);
	}
	//  We rebuild the disassembly
	disassembly_ = explorer_.disassembler()->disassemble();
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

void UI::DrawSelectRect(const char* buffer)
{
	ImVec2 text_size  = ImGui::CalcTextSize(buffer);
	ImVec2 cursor_pos = ImGui::GetCursorScreenPos();
	ImGui::GetWindowDrawList()->AddRectFilled(cursor_pos, ImVec2(cursor_pos.x + text_size.x, cursor_pos.y + text_size.y), ImGui::GetColorU32(select_color));
}

//  Draws an address with specific style
//  and handle interactions
void UI::DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions /* interactions */, const ImVec4& color)
{
	char buffer[256];

	switch (display_style)
	{
		case kDisplayHex:
			snprintf(buffer, 256, "%04x", adrs);
			break;
		case kDisplayDecimal:
			snprintf(buffer, 256, "%5d", adrs);
			break;
		case kDisplayLabel:
		{
			auto lbl = explorer().annotations().label_from_adrs(adrs);
			if (lbl)
				snprintf(buffer, 256, "%s", lbl->name().c_str());
			else
				snprintf(buffer, 256, "%04x", adrs);
		}
		break;
		case kDisplayDisplacement:
		{
			auto lbl = explorer().annotations().label_before_adrs(adrs, 99);
			if (!lbl)
				snprintf(buffer, 256, "%04x       ", adrs);
			else if (lbl->start_adrs() == adrs)
				snprintf(buffer, 256, "%s   ", lbl->name().c_str());
			else if (adrs - lbl->start_adrs() < 10)
				snprintf(buffer, 256, "%s+%d ", lbl->name().c_str(), adrs - lbl->start_adrs());
			else
				snprintf(buffer, 256, "%s+%d", lbl->name().c_str(), adrs - lbl->start_adrs());
			while (strlen(buffer) < 8 + 1 + 2)
                strlcat(buffer, " ", sizeof(buffer));
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

	ImGui::TextColored(color, "%s", buffer); // Display address
}

void UI::DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions /* interactions */ )
{
	DrawAddress(adrs, display_style, kInteractNone, adrs_color);
}

//  #### Should pass an optional address for interaction
void UI::DrawByte(uint8_t byte, eDisplayStyle display_style, eInteractions /* interactions */, adrs_t adrs)
{
	char buffer[256];

	switch (display_style)
	{
		case kDisplayHex:
			snprintf(buffer, 256, "%02x", byte);
			break;
		case kDisplayAscii:
		{
			uint8_t c = byte & 0x7f;
			if (c < 32 || c > 127)
				c = ' ';
			snprintf(buffer, 3, "%c ", c);
			break;
		}
		case kDisplayBinary:
			snprintf(buffer, 256, "%c%c%c%c%c%c%c%c",
			    byte & 0x80 ? '1' : '0',
			    byte & 0x40 ? '1' : '0',
			    byte & 0x20 ? '1' : '0',
			    byte & 0x10 ? '1' : '0',
			    byte & 0x08 ? '1' : '0',
			    byte & 0x04 ? '1' : '0',
			    byte & 0x02 ? '1' : '0',
			    byte & 0x01 ? '1' : '0');
			break;
		case kDisplayOctal:
			snprintf(buffer, 256, "%03o", byte);
			break;
		case kDisplayDecimal:
			snprintf(buffer, 256, "%3d", byte);
			break;
		default:
			snprintf(buffer, 256, "??");
			break;
	}

	if (is_hoover(adrs))
	{
		UI::DrawSelectRect(buffer);
		ImGui::TextColored(byte_select_color, "%s", buffer);
	}
	else
		ImGui::TextColored(byte_color, "%s", buffer);

	// if (ImGui::IsItemHovered())
	// {
	//     inspect_adrs( adrs, true );
	// }
	// if (ImGui::IsItemClicked())
	// {
	//     inspect_adrs( adrs, false );
	// }
	ImGui::SameLine();
}

/*
// obsolete
void UI::DrawByte( uint8_t b, adrs_t adrs )
{
    char buffer[3];

        //  How to display the byte
    if (force_ascii_)
    {
        uint8_t c = b&0x7f;
        if (c<32 || c>127)
            c = ' ';
        snprintf( buffer, 3, "%c ", c);
    }
    else
        snprintf( buffer, 3, "%02x", b );


    auto color = byte_color;
    if (hoover_[adrs])
    {
        color = select_color;
        
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
    }

    ImGui::TextColored(color, "%s", buffer ); // Display byte

    if (hoover_[adrs])
    {
        ImGui::PopStyleColor( 4 );        
    }

    if (ImGui::IsItemHovered())
    {
        // hover
        // std::clog << "Item hovered: " << adrs << std::endl;
        // Display a message within the ImGui window when the item is hovered
        // ImGui::BeginTooltip();
        // ImGui::Text("Item hovered: %02x", b);
        // ImGui::EndTooltip();
        hoover_[adrs] = true;

        //  Show the byte inspector
        byte_inspector_ = std::make_unique<ByteInspectorPanel>( *this, explorer_.rom().get(adrs) );
        byte_inspector_->unique();
    }
    else
        hoover_[adrs] = false;

    if (ImGui::IsItemClicked())
    {
        panels_.push_back( std::make_unique<ByteInspectorPanel>( *this, explorer_.rom().get(adrs) ) );
        panels_.back()->set_closable( true );
    }

    ImGui::SameLine();
}
*/

void UI::DrawBytes(const Line& l, eDisplayStyle display_style, eInteractions interactions)
{
	for (int i = 0; i != l.byte_count(); i++)
	{
		DrawByte(l.get_byte(i), display_style, interactions, l.start_adrs_ + i);
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

		//  Byte info if needed
		if (byte_inspector_)
			byte_inspector_->draw();

		//  Address info if needed
		if (adrs_inspector_)
			adrs_inspector_->draw();

		//  Data inspector
		if (data_inspector_panel_)
			data_inspector_panel_->draw();

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
			disassembly_  = explorer_.disassembler()->disassemble();
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
