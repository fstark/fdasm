#pragma once

#define IMGUI_IMPL_OPENGL_LOADER_GLAD

#include "imgui.h"
#include "imgui_impl_opengl3.h"
#include "imgui_impl_sdl2.h"

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
extern ImVec4 byte_color;
extern ImVec4 byte_select_color;
extern ImVec4 data_color;

extern ImVec4 std_color;
extern ImVec4 std_select_color;
extern ImVec4 mnemonic_color;
extern ImVec4 string_color;

extern ImVec4 select_color;

extern ImVec4 line_color;

extern ImVec4 data_ref_color;
extern ImVec4 bg_select_color;

void paint_line(ImU32 color);
void paint_element( const char *str, ImU32 color);
