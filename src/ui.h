#pragma once

#include "explorer.h"

struct SDL_Window;
typedef void *SDL_GLContext;
struct ImFont;

class UI
{
    Explorer &explorer_;

    void InitImgUI();
    void ShutdownImgUI();

    SDL_Window *window = NULL;
    SDL_GLContext gl_context;

    ImFont *tiny_font_;
    ImFont *large_font_;

    //  Displays an instruction
    void DisplayInstruction( const Instruction &instruction );

    //  Show info window
    uint8_t info_byte_ = 0;
    void ShowByteInfoWindow();

    void DrawByte( uint8_t b, adrs_t adrs );
    void DrawBytes( const Line &l );

public:
    UI( Explorer &explorer ) : explorer_{ explorer }
    {
        InitImgUI();
    }

    ~UI()
    {
        ShutdownImgUI();
    }

    void Run();
};
