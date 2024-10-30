#pragma once

#include "explorer.h"

struct SDL_Window;
typedef void* SDL_GLContext;
struct ImFont;

#include "adrsinspector.h"
#include "codeinspector.h"
#include "datainspector.h"
#include "byteinspector.h"

#include "uicommon.h"

//	This class represents the UI, aka the whole application
class UI
{
public:
	UI(Explorer& explorer)
	    : explorer_{ explorer }
	{
		//  We disassemble the code
		disassembly_ = explorer_.disassembler()->disassemble();

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
	}

	~UI()
	{
		shutdown_imgui();
	}

	void replace_label(const std::string& label, adrs_t adrs, Annotations::RegionType type);

	void remove_label_if_exists(const std::string& label)
	{
		remove_label_ = label;
		(void)explorer_.annotations().write_annotations();
	}

	void set_label_type(const std::string& label, Annotations::RegionType new_type)
	{
		auto lbl = explorer().annotations().label_from_name(label);
		lbl->set_type(new_type);
		disassembly_ = explorer().disassembler()->disassemble();
		(void)explorer_.annotations().write_annotations();
	}

	void replace_comment( adrs_t line, const std::string &comment )
	{
		explorer_.annotations().replace_comment( line, comment );
		(void)explorer_.annotations().write_annotations();
	}

	bool hoover_ = false;
	adrs_t hoover_adrs_ = 0;

	bool new_hoover_ = false;
	adrs_t new_hoover_adrs_ = 0;

	//  Hoover mecanism
	void hoover(adrs_t adrs, int , bool flag)
	{
		if (flag)
		{
			new_hoover_ = true;
			new_hoover_adrs_ = adrs;
		}
	}

	bool is_hoover(adrs_t adrs) const
	{
		return hoover_ && adrs==hoover_adrs_;
	}

	void hoover_start_frame()
	{
		hoover_ = new_hoover_;
		hoover_adrs_ = new_hoover_adrs_;
		new_hoover_ = false;
	}

	typedef enum
	{
		kDisplayHex,         //  As hex
		kDisplayAscii,       //  As ASCII
		kDisplayBinary,      //  As binary
		kDisplayOctal,       //  As octal
		kDisplayDecimal,     //  As decimal
		kDisplayLabel,       //  As a label
		kDisplayDisplacement //  As a label with displacement
	} eDisplayStyle;

	typedef enum
	{
		kInteractNone    = 0,    //  No interaction
		kInteractTooltip = 0x01, //  Hover display tooltip
		kInteractInspect = 0x02, //  Click selects in the inspector
		kInteractOpen    = 0x04  //  Open a new panel on click
	} eInteractions;

	eDisplayStyle address_display_style_ = kDisplayHex;
	eDisplayStyle bytes_display_style_   = kDisplayHex;

	//  If true, show ASCII
	bool force_ascii_ = false;

	//  If true, display labels+displacement for line addresses
	bool force_labels_ = false;

	static void DrawSelectRect(const char* buffer);

	void DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions interactions);
	void DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions interactions, const ImVec4& color);

	// void DrawAddress( adrs_t adrs );
	void DrawAddress(const Line& l);

	void DrawByte(uint8_t byte, eDisplayStyle display_style, eInteractions interactions, adrs_t adrs);
	void DrawByte(uint8_t b, adrs_t adrs); // obsolete
	void DrawBytes(const Line& l, eDisplayStyle display_style, eInteractions interactions);

	void add_panel(std::unique_ptr<Panel> panel)
	{
		panels_.push_back(std::move(panel));
	}

	void update_adrs_panel( adrs_t adrs )
	{
		adrs_inspector_->set_data(adrs);
	}

	void update_byte_panel( uint8_t b )
	{
		byte_inspector_->set_data(b);
	}

	void update_code_panel( adrs_t adrs )
	{
		code_inspector_->set_data(adrs);
	}

	void update_data_panel( adrs_t adrs )
	{
		data_inspector_panel_->set_data(adrs);
	}

	void new_disassembly_panel( adrs_t adrs )
	{
		auto cip = std::make_unique<CodeInspectorPanel>(*this, adrs);
		cip->scroll_to_adrs(adrs);
		panels_.push_back(std::move(cip));
		panels_.back()->set_closable(true);
	}

	void inspect_adrs(adrs_t adrs, bool /* hoover */)
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

	const std::vector<Line>& lines() const { return disassembly_.lines(); }
	// Incorrect, should be stored elsewhere
	//  Probably the explorer

	const Disassembly& disassembly() const { return disassembly_; }

	void run();

	//  Theme support
	ImFont* large_font() const { return large_font_; }
	ImFont* tiny_font() const { return tiny_font_; }
	const Explorer& explorer() const { return explorer_; }
	Explorer& explorer() { return explorer_; }
	void close_panels()
	{
		panels_.erase(std::remove_if(panels_.begin(), panels_.end(), [](const std::unique_ptr<Panel>& p)
		                  { return !p->is_open(); }),
		    panels_.end());
	}

private:
	Explorer& explorer_;

	void init_imgui();
	void shutdown_imgui();

	SDL_Window* window = NULL;
	SDL_GLContext gl_context;

	ImFont* tiny_font_;
	ImFont* large_font_;

	//  If true, click follows links
	bool link_ = false;

	//  Inspectors
	std::unique_ptr<CodeInspectorPanel> code_inspector_;
	std::unique_ptr<ByteInspectorPanel> byte_inspector_;
	std::unique_ptr<AdrsInspectorPanel> adrs_inspector_;
	std::unique_ptr<DataInspectorPanel> data_inspector_panel_;

	std::vector<std::unique_ptr<Panel>> panels_;

	Disassembly disassembly_;

	//  If not empty, we remove this label after the next draw
	std::string remove_label_;

};
