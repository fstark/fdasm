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

    //  If true, show ASCII
    bool show_ascii_ = false;

    //  Displays an instruction
    void DisplayInstruction( const Instruction &instruction );

    //  Inspect a byte
    uint8_t info_byte_ = 0;
    void ByteInspector();

    //  Inspect an address
    adrs_t info_adrs_ = 0;
    Label *info_lbl_ = nullptr;
    void AdrsInspector();
    std::vector<XRef> xrefs_to_;

    void inspect_adrs( adrs_t adrs )
    {
        info_adrs_ = adrs;
        info_lbl_ = Annotations::label_from_adrs( adrs );

        //  All the references to this address
        xrefs_to_ = explorer_.xrefs().xrefs_to( adrs );
    }
    
    void DrawAddress( const Line &l );  //  Very wrong
    void DrawByte( uint8_t b, adrs_t adrs );
    void DrawBytes( const Line &l );

public:
    UI( Explorer &explorer ) : explorer_{ explorer }
    {
        InitImgUI();
        inspect_adrs( 0 );
    }

    ~UI()
    {
        ShutdownImgUI();
    }

    void Run();
};
