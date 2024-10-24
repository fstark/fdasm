#pragma once

#include "explorer.h"

struct SDL_Window;
typedef void *SDL_GLContext;
struct ImFont;

#include "inspector.h"

#include "datainspector.h"
#include "codeinspector.h"
#include "adrsinspector.h"

class UI
{
    Explorer &explorer_;

    void InitImgUI();
    void ShutdownImgUI();

    SDL_Window *window = NULL;
    SDL_GLContext gl_context;

    ImFont *tiny_font_;
    ImFont *large_font_;


    //  If true, click follows links
    bool link_ = false;
    
    //  Inspectors
    std::unique_ptr<Panel> code_inspector_;
    std::unique_ptr<Panel> byte_inspector_;
    std::unique_ptr<Panel> adrs_inspector_;
    std::unique_ptr<Panel> data_inspector_panel_;
    
    std::vector<std::unique_ptr<Panel>> panels_;

    Disassembly disassembly_;

    // bool hoover_[65536];
    int hoover_tag_;
    adrs_t hoover_adrs_;  //  Hoover is single address

public:
    //  Hoover mecanism

    void hoover( adrs_t adrs, int tag, bool flag )
    {
        if (flag /* && hoover_tag_==-1*/)
        {
            hoover_tag_ = tag;
            hoover_adrs_ = adrs;
            // std::clog << "HOOVER  ON " << hoover_adrs_ << " TAG " << tag << "\n";
        }
        if (!flag && hoover_tag_==tag && hoover_adrs_==adrs)
        {
            // std::clog << "UNHOOVER ON " << hoover_adrs_ << "/" << hoover_tag_ << " BY " << tag << "\n";
            hoover_tag_ = -1;
        }
    }

    bool is_hoover( adrs_t adrs ) const
    {
        if (hoover_tag_==-1)
            return false;
        // if (adrs==hoover_adrs_)
        //     std::clog << "HOOVER FOUND ON " << adrs << "\n";
        return adrs==hoover_adrs_;
    }

    typedef enum
    {
        kDisplayHex,            //  As hex
        kDisplayAscii,          //  As ASCII
        kDisplayBinary,         //  As binary
        kDisplayOctal,          //  As octal
        kDisplayDecimal,        //  As decimal
        kDisplayLabel,          //  As a label
        kDisplayDisplacement    //  As a label with displacement
    }   eDisplayStyle;

    typedef enum
    {
        kInteractNone = 0,             //  No interaction
        kInteractTooltip = 0x01,       //  Hover display tooltip
        kInteractInspect = 0x02,        //  Click selects in the inspector 
        kInteractOpen = 0x04           //  Open a new panel on click
    }   eInteractions;


    eDisplayStyle address_display_style_ = kDisplayHex;
    eDisplayStyle bytes_display_style_ = kDisplayHex;

    //  If true, show ASCII
    bool force_ascii_ = false;

    //  If true, display labels+displacement for line addresses
    bool force_labels_ = false;

    UI( Explorer &explorer ) : explorer_{ explorer }, hoover_tag_( -1 )
    {
            //  We disassemble the code
        disassembly_ = explorer_.disassembler()->disassemble();

        InitImgUI();
        // inspect_adrs( 0 );
        code_inspector_ = std::make_unique<CodeInspectorPanel>( *this, 0 );
        data_inspector_panel_ = std::make_unique<DataInspectorPanel>( *this );
    }

    ~UI()
    {
        ShutdownImgUI();
    }

    static void Select( const char *buffer );

    void DrawAddress( adrs_t adrs, eDisplayStyle display_style, eInteractions interactions );
    // void DrawAddress( adrs_t adrs );
    void DrawAddress( const Line &l );

    void DrawByte( uint8_t byte, eDisplayStyle display_style, eInteractions interactions, adrs_t adrs );
    void DrawByte( uint8_t b, adrs_t adrs );// obsolete
    void DrawBytes( const Line &l, eDisplayStyle display_style, eInteractions interactions );

    void InspectAdrs( adrs_t adrs, bool hoover )
    {
        if (hoover)
        {
            adrs_inspector_  = std::make_unique<AdrsInspectorPanel>( *this, adrs );
            adrs_inspector_->unique();
        }
        else
        {
            if (!link_)
            {
                panels_.push_back( std::make_unique<AdrsInspectorPanel>( *this, adrs ) );
                panels_.back()->set_closable( true );
            }
            else
            {
                std::clog<< "Adding panel"  << std::endl;
                auto cip = std::make_unique<CodeInspectorPanel>( *this, adrs );
                cip->scroll_to( disassembly_.adrs_to_line( adrs ) );
                panels_.push_back( std::move(cip) );
                panels_.back()->set_closable( true );
            }
        }
    }


    const std::vector<Line> &lines() const { return disassembly_.lines(); }
                                                        // Incorrect, should be stored elsewhere
                                                        //  Probably the explorer

    void Run();


    //  Theme support
    ImFont *large_font() const { return large_font_; }
    ImFont *tiny_font() const { return tiny_font_; }
    const Explorer &explorer() const { return explorer_; }
    void remove_panel( Panel *panel )
    {
        panels_.erase( std::remove_if( panels_.begin(), panels_.end(), [panel](const std::unique_ptr<Panel> &p) { return p.get() == panel; } ), panels_.end() );
    }  
};
