#pragma once

#define IMGUI_IMPL_OPENGL_LOADER_GLAD

#include "imgui.h"
#include "imgui_impl_opengl3.h"
#include "imgui_impl_sdl2.h"

#include "IconsFontAwesome6.h"

#include <SDL.h>
#include <SDL_image.h>
#if defined(IMGUI_IMPL_OPENGL_ES2)
#include <SDL_opengles2.h>
#else
#include <SDL_opengl.h>
#endif

//  #### Bad
extern ImVec4 dbg_color;

extern ImVec4 adrs_color;
extern ImVec4 data_color;

extern ImVec4 std_color;
extern ImVec4 std_select_color;

extern ImVec4 select_color;
extern ImVec4 select_color2;

extern ImVec4 line_color;

extern ImVec4 data_ref_color;
extern ImVec4 info_color;           //  Color for an non-vital information


void paint_line(ImU32 color);
void paint_element( const char *str, ImU32 color);

typedef enum
{
    kDisplayHex,            //  As hex
    kDisplayAscii,          //  As ASCII
    kDisplayBinary,         //  As binary
    kDisplayOctal,          //  As octal
    kDisplayDecimal,        //  As decimal
    kDisplayLabel,          //  As a label
    kDisplayDisplacement,   //  As a label with displacement

    kDisplayStyleASM = 0x10 //  In a way suitable for assembly inclusion
} eDisplayStyle;

void format_byte( char *buffer, uint8_t byte, eDisplayStyle display_style );

//  A small button with a singlt icon
bool small_icon_button(const char* label);

//  True if we are hovering on the current line
bool is_hover_line();
