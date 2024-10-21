#include "ui.h"


#include <memory>
#include "disassembler.h"
#include "annotations.h"
#include "label.h"
#include "explorer.h"
#include <stdio.h>


#include "imgui.h"

#include "imgui_impl_sdl2.h"
#include "imgui_impl_opengl3.h"

#include <SDL.h>
#include <SDL_image.h>
#if defined(IMGUI_IMPL_OPENGL_ES2)
#include <SDL_opengles2.h>
#else
#include <SDL_opengl.h>
#endif

void UI::InitImgUI()
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
    SDL_WindowFlags window_flags = (SDL_WindowFlags)(SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI);
    window = SDL_CreateWindow("8085 Disassembler", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1280, 720, window_flags);
    gl_context = SDL_GL_CreateContext(window);
    SDL_GL_MakeCurrent(window, gl_context);
    SDL_GL_SetSwapInterval(1); // Enable vsync

    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();
    //ImGui::StyleColorsLight();

    // Setup Platform/Renderer backends
    ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
    ImGui_ImplOpenGL3_Init(glsl_version);

    // Initialize ImGui
    ImGui::CreateContext();

    // Set the font size
    io.Fonts->AddFontFromFileTTF("external/imgui/misc/fonts/ProggyClean.ttf", 13.0f);
    tiny_font_ = io.Fonts->AddFontFromFileTTF("external/imgui/misc/fonts/ProggyClean.ttf", 26.0f/3);
    large_font_ = io.Fonts->AddFontFromFileTTF("external/imgui/misc/fonts/ProggyClean.ttf", 26.0f);
}

static bool hoover[65536];

auto adrs_color = ImVec4(244/255.0, 71/255.0, 71/255.0, 1.0f);
auto byte_color = ImVec4(71/255.0, 244/255.0, 71/255.0, 1.0f);
auto data_color = ImVec4(0.8f, 0.8f, 0.1f, 1.0f);

auto std_color = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
auto mnemonic_color = ImVec4(84/255.0, 147/255.0, 201/255.0, 1.0f);
auto string_color = ImVec4(198/255.0, 140/255.0, 116/255.0, 1.0f);

auto select_color = ImVec4(255/255.0, 255/255.0, 255/255.0, 1.0f);

void UI::DrawAddress( const Line &l )
{
    //  Draw the Address for the line
    char buffer[5];
    snprintf( buffer, 5, "%04x", l.start_adrs_ );
    ImGui::TextColored(adrs_color, "%s", buffer ); // Display address
    if (ImGui::IsItemHovered())
    {
        // inspect_adrs( l.start_adrs_ );
    }
    ImGui::SameLine();
}

void UI::DrawByte( uint8_t b, adrs_t adrs )
{
    char buffer[3];

        //  How to display the byte
    if (show_ascii_)
    {
        uint8_t c = b&0x7f;
        if (c<32 || c>127)
            c = ' ';
        snprintf( buffer, 3, "%c ", c);
    }
    else
        snprintf( buffer, 3, "%02x", b );


    auto color = byte_color;
    if (hoover[adrs])
    {
        color = select_color;
        
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
        ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(1.0f, 0.0f, 0.0f, 1.0f)); // Slightly darker green when active
    }

    ImGui::TextColored(color, "%s", buffer ); // Display byte

    if (hoover[adrs])
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
        hoover[adrs] = true;

        //  Show the byte inspector
        byte_inspector_ = std::make_unique<ByteInspectorPanel>( *this, explorer_.rom().get(adrs) );
        byte_inspector_->unique();
    }
    else
        hoover[adrs] = false;

    if (ImGui::IsItemClicked())
    {
        panels_.push_back( std::make_unique<ByteInspectorPanel>( *this, explorer_.rom().get(adrs) ) );
        panels_.back()->set_closable( true );
    }

    ImGui::SameLine();
}

void UI::DrawBytes( const Line &l )
{
    for (int i = 0;i!=l.byte_count();i++)
    {
        DrawByte( l.get_byte(i), l.start_adrs_+i );
    }
}

void UI::Run()
{
    int done = 0;

    ImGuiIO& io = ImGui::GetIO();

    Disassembler *disassembler = explorer_.disassembler();

    auto lines = disassembler->disassemble();

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
                show_ascii_ = true;
            if (event.type == SDL_KEYUP && event.key.keysym.sym == 'a')
                show_ascii_ = false;
        }

        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplSDL2_NewFrame();
        ImGui::NewFrame();

    // Create a new ImGui window
    ImGui::Begin("ROM Disassembly");

    ImGui::Text("a: ASCII");

    // Get imgui character width
    float char_width = ImGui::CalcTextSize("A").x;
    // 4 bytes + ':' + 8*2 bytes + 7 sep = 28 + 2 margins
    float adrs_width = 30*char_width;
    float label_width = 21*char_width;

    ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);
    ImGuiListClipper clipper;
    clipper.Begin(lines.size(), ImGui::GetTextLineHeightWithSpacing());
    while (clipper.Step())
    {
        for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
        {
            const auto& line = lines[i];


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


            auto byte_color = data_color;
            if (hoover[line.start_adrs_])
                byte_color = select_color;
            // Display line address and text in two columns
            // First one being constant size
            // ImGui::TextColored(byte_color, "%s", line.adrs_.c_str()); // Display address

            if (!line.is_empty())
            {
                DrawAddress( line );
                DrawBytes( line );
            }
            else
            {
                ImGui::SameLine(label_width);
                ImGui::TextColored( std_color, "%s:", line.spans()[0].content().c_str() );
                ImGui::SameLine();
            }

            ImGui::SameLine(adrs_width);
            // ImGui::Text("%s", line.text_.c_str()); // Display disassembled text
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
                        hack = true;
                        is_adrs = true;
                        break;
                    case Span::kString:
                        color = string_color;
                        break;
                    default:
                        color = std_color;
                        break;
                }

                //  Look if address has a label:
                Label *lbl;
                if (hack && (lbl = Annotations::label_from_adrs(span.adrs())))
                {
                    ImGui::TextColored(adrs_color, "%s", lbl->name().c_str() ); // Display label
                    if (is_adrs && ImGui::IsItemHovered())
                    {
                        adrs_inspector_  = std::make_unique<AdrsInspectorPanel>( *this, span.adrs() );
                        adrs_inspector_->unique();
                    }
                    if (is_adrs && ImGui::IsItemClicked())
                    {
                        panels_.push_back( std::make_unique<AdrsInspectorPanel>( *this, span.adrs() ) );
                        panels_.back()->set_closable( true );
                    }
                }
                else
                {
                    ImGui::TextColored( color, "%s", span.content().c_str() );
                    if (is_mnem && ImGui::IsItemHovered())
                    {
                        ImGui::BeginTooltip();
                        auto v = explorer_.rom().get(line.start_adrs_);
                        ByteInspectorPanel::DisplayInstruction( *this, explorer_.cpu_info().instruction( v ) );
                        ImGui::EndTooltip();
                    }
                    // #### wtf copy/paste
                    if (is_adrs && ImGui::IsItemHovered())
                    {
                        adrs_inspector_  = std::make_unique<AdrsInspectorPanel>( *this, span.adrs() );
                        adrs_inspector_->unique();
                    }
                    if (is_adrs && ImGui::IsItemClicked())
                    {
                        panels_.push_back( std::make_unique<AdrsInspectorPanel>( *this, span.adrs() ) );
                        panels_.back()->set_closable( true );
                    }
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


//ImGui::IsItemHovered()

    // End the ImGui window
    ImGui::End();

    // Show demo ImgUI window
    ImGui::ShowDemoWindow();

    //  Byte info if needed
    if (byte_inspector_)
        byte_inspector_->Draw();

    //  Address info if needed
    if (adrs_inspector_)
        adrs_inspector_->Draw();

    for (const auto &p:panels_)
        p->Draw();

    //  Remove all panels that are not open
    panels_.erase( std::remove_if( panels_.begin(), panels_.end(), [](const std::unique_ptr<Panel> &p) { return !p->is_open(); } ), panels_.end() );


        // Rendering
        ImGui::Render();
        glViewport(0, 0, (int)io.DisplaySize.x, (int)io.DisplaySize.y);
        // glClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        glClearColor(1,1,1,1);
        glClear(GL_COLOR_BUFFER_BIT);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        SDL_GL_SwapWindow(window);

    }
}

/* static */ void ByteInspectorPanel::DisplayInstruction( const UI &ui, const Instruction &instruction )
{
    ImGui::PushFont(ui.large_font());
    ImGui::Text("%s", instruction.mnemonic().c_str());
    ImGui::PopFont();
    ImGui::Separator();
    ImGui::PushTextWrapPos(320);
    ImGui::Text("%s", instruction.description().c_str());
    ImGui::Text("%s", instruction.flags().c_str());
    ImGui::Text("%s", instruction.effect().c_str());
    ImGui::PopTextWrapPos();
}

void Panel::Draw()
{
    //  Window with 320, not resizable
    // ImGui::SetNextWindowSize(ImVec2(320, 200));

    bool *is_open_ptr = nullptr;
    if (is_closable_)
        is_open_ptr = &is_open_;
    ImGui::Begin( name().c_str(), is_open_ptr, ImGuiWindowFlags_NoResize|ImGuiWindowFlags_AlwaysAutoResize);

    DoDraw();

    ImGui::End();
}

void ByteInspectorPanel::DoDraw()
{
    // Display the byte info in a large font

    char info_char_ = data_&0x7f;
    if (info_char_<32 || info_char_>126)
        info_char_ = ' ';

    ImGui::PushFont(ui_.large_font());
    ImGui::Text("%02X|%c|%3d|%03o|%c%c%c%c %c%c%c%c",
        data_,
        info_char_,
        data_,
        data_,
        data_&0x80?'1':'0',
        data_&0x40?'1':'0',
        data_&0x20?'1':'0',
        data_&0x10?'1':'0',
        data_&0x08?'1':'0',
        data_&0x04?'1':'0',
        data_&0x02?'1':'0',
        data_&0x01?'1':'0'
        );
    ImGui::PopFont();
    ImGui::PushFont(ui_.tiny_font());
    ImGui::Text("hex asc dec oct binary");
    ImGui::PopFont();
    ImGui::Separator();
    auto i = ui_.explorer().cpu_info().instruction(data_);
    DisplayInstruction( ui_, i );
}

void AdrsInspectorPanel::DoDraw()
{
    ImGui::PushFont(ui_.large_font());
    if (label_)
    {
        ImGui::Text("%s:", label_->name().c_str());
        ImGui::SameLine();
    }
    ImGui::Text("%04X", data_);
    ImGui::PopFont();
    ImGui::Separator();
    if (label_)
    {
        ImGui::Text("%s", label_->name().c_str());
    }

    for (const auto &ref:xrefs_to_)
    {
        auto adrs = ref.from_;

        switch (ref.type_)
        {
            case XRef::kJUMP:
                ImGui::TextColored(ImVec4(244/255.0, 71/255.0, 71/255.0, 1.0f), "%04X:", adrs);
                break;
            case XRef::kREF:
                ImGui::TextColored(ImVec4(71/255.0, 71/255.0, 244/255.0, 1.0f), "%04X:", adrs);
                break;
            case XRef::kDATA:
                ImGui::TextColored(ImVec4(128/255.0, 128/255.0, 128/255.0, 1.0f), "%04X:", adrs);
                break;
        }

        if (ref.instruction)
        {
            ImGui::SameLine();
            ImGui::TextColored(ImVec4(244/255.0, 71/255.0, 71/255.0, 1.0f), "%s", ref.instruction->mnemonic().c_str());
        }
        else
        {
            ImGui::SameLine();
            ImGui::TextColored(ImVec4(128/255.0, 128/255.0, 128/255.0, 1.0f), "DATA");
        }
    }
}

void UI::ShutdownImgUI()
{
    // Cleanup
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplSDL2_Shutdown();
    ImGui::DestroyContext();

    SDL_GL_DeleteContext(gl_context);
    SDL_DestroyWindow(window);
    SDL_Quit();
}


AdrsInspectorPanel::AdrsInspectorPanel( UI &ui, adrs_t data ) : InspectorPanel( ui, data )
{
    title_ = "Address";
    //  The label for this address if any
    label_ = Annotations::label_from_adrs( data_ );
    xrefs_to_ = ui.explorer().xrefs().xrefs_to( data_ );
}
