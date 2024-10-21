#pragma once

#include "explorer.h"

struct SDL_Window;
typedef void *SDL_GLContext;
struct ImFont;

class UI;

//  A panel that is shown by the main loop
class Panel
{

    protected:
    bool is_open_ = true;
    bool is_closable_ = false;
    UI &ui_;
    std::string title_;
    std::string id_;

        //  Override to perform the drawing
    virtual void DoDraw() = 0;
public:
    Panel( UI &ui ) : ui_{ ui }
    {
        title_ = "";
        id_ = "";
    }
    virtual ~Panel() {}

    void Draw();

    const std::string name() const { return title_+"##"+id_; }

        //  All windows with this title will be the same
    void unique( const std::string id = "" ) { id_ = id; }

    bool is_open() const { return is_open_; }

    void set_closable( bool closable ) { is_closable_ = closable; }
};

//  A panel that *inspects* a specific piece of data
//  Such panels can be duplicated
template <class T> class InspectorPanel : public Panel
{
protected:
    T data_;
public:
    InspectorPanel( UI &ui, T data ) : Panel( ui ), data_{ data }
    {
        title_ = "";
        id_ = std::to_string( (long)this ); //  #### Another Unique ID would be better
    }
};

class ByteInspectorPanel : public InspectorPanel<uint8_t>
{
    public:
    ByteInspectorPanel( UI &ui, uint8_t data ) : InspectorPanel( ui, data )
    {
        title_ = "Byte";
    }
    void DoDraw() override;

    static void DisplayInstruction( const UI&ui, const Instruction &instruction );
};

class AdrsInspectorPanel : public InspectorPanel<adrs_t>
{
    Label *label_;
    std::vector<XRef> xrefs_to_;
    public:
    AdrsInspectorPanel( UI &ui, adrs_t data );
    void DoDraw() override;
};

class CodeInspectorPanel : public InspectorPanel<adrs_t>
{
    Label *label_;
    std::vector<XRef> xrefs_to_;
    public:
    CodeInspectorPanel( UI &ui, adrs_t data );
    void DoDraw() override;
};

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

    //  The byte inspector
    std::unique_ptr<Panel> byte_inspector_;
    std::vector<std::unique_ptr<Panel>> panels_;

    //  Inspect a byte
    // uint8_t info_byte_ = 0;
    // void ByteInspector();

    //  Inspect an address
    // adrs_t info_adrs_ = 0;
    // Label *info_lbl_ = nullptr;
    void AdrsInspector();

    std::unique_ptr<Panel> adrs_inspector_;

    // std::vector<XRef> xrefs_to_;

    void DrawAddress( const Line &l );  //  Very wrong
    void DrawByte( uint8_t b, adrs_t adrs );
    void DrawBytes( const Line &l );

public:
    UI( Explorer &explorer ) : explorer_{ explorer }
    {
        InitImgUI();
        // inspect_adrs( 0 );
    }

    ~UI()
    {
        ShutdownImgUI();
    }

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
