#include <iostream>
#include <fstream>
#include <vector>
#include "disassembler.h"

// Start of wxWidgets "Hello World" Program
#include <wx/wx.h>
 
int load_rom( const std::string rom_file );


class AsmView : public wxScrolledWindow
{
public:
	AsmView(wxWindow *parent, wxWindowID id = wxID_ANY, const wxPoint &pos = wxDefaultPosition, const wxSize &size = wxDefaultSize, long style = 0, const wxString &name = wxPanelNameStr)
		: wxScrolledWindow(parent, id, pos, size, style, name)
	{
    	SetMinSize( wxSize(200, 100) );
		SetVirtualSize( wxSize(200, 10000) );
		SetScrollRate( 5, 5 );
		SetScrollbar(wxVERTICAL, 0, 16, 50);
	}
	
	void paintEvent(wxPaintEvent & evt)
	{
		wxPaintDC dc(this);
		render(dc);
	}
    void paintNow()
	{
		wxClientDC dc(this);
		render(dc);
	}
        
	void render(wxDC& dc)
	{
		int x, y;
		GetViewStart(&x, &y); // Get the current scroll position

		int pixelsPerUnitX, pixelsPerUnitY;
		GetScrollPixelsPerUnit(&pixelsPerUnitX, &pixelsPerUnitY); // Correct usage

		x *= pixelsPerUnitX; // Convert scroll units to pixels
		y *= pixelsPerUnitY;

		// Adjust drawing coordinates by the current scroll position
		dc.DrawRectangle(0 - x, 0 - y, 200, 10000);
		dc.DrawText("TEST", 20 - x, 15 - y);
	}

    DECLARE_EVENT_TABLE()
};

BEGIN_EVENT_TABLE(AsmView, wxPanel)

    // EVT_MOTION(wxCustomButton::mouseMoved)
    // EVT_LEFT_DOWN(wxCustomButton::mouseDown)
    // EVT_LEFT_UP(wxCustomButton::mouseReleased)
    // EVT_RIGHT_DOWN(wxCustomButton::rightClick)
    // EVT_LEAVE_WINDOW(wxCustomButton::mouseLeftWindow)
    // EVT_KEY_DOWN(wxCustomButton::keyPressed)
    // EVT_KEY_UP(wxCustomButton::keyReleased)
    // EVT_MOUSEWHEEL(wxCustomButton::mouseWheelMoved)

    // catch paint events
    EVT_PAINT(AsmView::paintEvent)

END_EVENT_TABLE()

class MyApp : public wxApp
{
public:
    bool OnInit() override;
};
 
wxIMPLEMENT_APP(MyApp);
 
class MyFrame : public wxFrame
{
public:
    MyFrame();
 
	AsmView *asm_view_;

private:
    void OnHello(wxCommandEvent& event);
    void OnExit(wxCommandEvent& event);
    void OnAbout(wxCommandEvent& event);

    void OnToggleHex(wxCommandEvent& event);

    wxDECLARE_EVENT_TABLE();
};
 
enum
{
    ID_Hello = 1
};
 
bool MyApp::OnInit()
{
    MyFrame *frame = new MyFrame();
    frame->Show(true);
    return true;
}

int ID_HEX = 2;
int ID_ASCII = 3;

MyFrame::MyFrame()
    : wxFrame(nullptr, wxID_ANY, "FReD 8085 Disassembler")
{
    wxMenu *menuFile = new wxMenu;
    menuFile->Append(ID_Hello, "&Hello...\tCtrl-H",
                     "Help string shown in status bar for this menu item");
    menuFile->AppendSeparator();
    menuFile->Append(wxID_EXIT);
 
    wxMenu *menuHelp = new wxMenu;
    menuHelp->Append(wxID_ABOUT);
 
    wxMenuBar *menuBar = new wxMenuBar;
    menuBar->Append(menuFile, "&File");
    menuBar->Append(menuHelp, "&Help");
 
    SetMenuBar( menuBar );
 
    CreateStatusBar();
    SetStatusText("Welcome to wxWidgets!");
 
    Bind(wxEVT_MENU, &MyFrame::OnHello, this, ID_Hello);
    Bind(wxEVT_MENU, &MyFrame::OnAbout, this, wxID_ABOUT);
    Bind(wxEVT_MENU, &MyFrame::OnExit, this, wxID_EXIT);

	//	Create toolbar
	wxToolBar *toolBar = CreateToolBar();
	toolBar->AddTool(ID_HEX, "Hexadecimal", wxBitmap("assets/hex.png"));
	toolBar->AddTool(ID_ASCII, "Ascii", wxBitmap("assets/ascii.png"));


	//	Load ROM file
	load_rom( "tests/M100rom.bin" );

	asm_view_ = new AsmView(this);
}

wxBEGIN_EVENT_TABLE(MyFrame, wxFrame)
    EVT_MENU(ID_HEX, MyFrame::OnToggleHex)
wxEND_EVENT_TABLE()

void MyFrame::OnToggleHex(wxCommandEvent& event)
{
        // m_tbar->ToggleTool(IDM_TOOLBAR_OTHER_1 +
        //                     event.GetId() - IDM_TOOLBAR_TOGGLERADIOBTN1, true);
	printf("Toggle Hex\n");
}


void MyFrame::OnExit(wxCommandEvent& event)
{
    Close(true);
}
 
void MyFrame::OnAbout(wxCommandEvent& event)
{
    wxMessageBox("This is a wxWidgets Hello World example",
                 "About Hello World", wxOK | wxICON_INFORMATION);
}
 
void MyFrame::OnHello(wxCommandEvent& event)
{
    wxLogMessage("Hello world from wxWidgets!");
}

int load_rom( const std::string rom_file )
{
	std::ifstream file(rom_file, std::ios::binary);
	if (!file) {
		std::cout << "Failed to open file: " << rom_file << std::endl;
		return 1;
	}

	// Get the size of the file
	file.seekg(0, std::ios::end);
	std::streampos fileSize = file.tellg();
	file.seekg(0, std::ios::beg);

	// Read the file into a buffer
	std::vector<uint8_t> buffer(fileSize);
	file.read((char *)buffer.data(), fileSize);

	// Close the file
	file.close();

	// Disassemble the buffer
    Disassembler disassembler(buffer,0);
	disassembler.disassemble();

	return 0;
}
