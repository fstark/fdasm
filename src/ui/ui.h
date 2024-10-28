#pragma once

#include "explorer.h"

struct SDL_Window;
typedef void* SDL_GLContext;
struct ImFont;

#include "adrsinspector.h"
#include "codeinspector.h"
#include "datainspector.h"

class UI
{
public:
	void replace_label(const std::string& label, adrs_t adrs, Annotations::RegionType type)
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
		(void)explorer_.annotations().write_regions();
	}

	void remove_label_if_exists(const std::string& label)
	{
		remove_label_ = label;
	}

	void set_label_type(const std::string& label, Annotations::RegionType new_type)
	{
		auto lbl = Annotations::label_from_name(label);
		lbl->set_type(new_type);
		disassembly_ = explorer_.disassembler()->disassemble();
	}

	//  Hoover mecanism
	void hoover(adrs_t adrs, int tag, bool flag)
	{
		if (flag /* && hoover_tag_==-1*/)
		{
			hoover_tag_  = tag;
			hoover_adrs_ = adrs;
			// std::clog << "HOOVER  ON " << hoover_adrs_ << " TAG " << tag << "\n";
		}
		if (!flag && hoover_tag_ == tag && hoover_adrs_ == adrs)
		{
			// std::clog << "UNHOOVER ON " << hoover_adrs_ << "/" << hoover_tag_ << " BY " << tag << "\n";
			hoover_tag_ = -1;
		}
	}

	bool is_hoover(adrs_t adrs) const
	{
		if (hoover_tag_ == -1)
			return false;
		// if (adrs==hoover_adrs_)
		//     std::clog << "HOOVER FOUND ON " << adrs << "\n";
		return adrs == hoover_adrs_;
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

	UI(Explorer& explorer)
	    : explorer_{ explorer }
	    , hoover_tag_(-1)
	{
		//  We disassemble the code
		disassembly_ = explorer_.disassembler()->disassemble();

		InitImgUI();
		// inspect_adrs( 0 );
		code_inspector_       = std::make_unique<CodeInspectorPanel>(*this, 0);
		data_inspector_panel_ = std::make_unique<DataInspectorPanel>(*this);
	}

	~UI()
	{
		ShutdownImgUI();
	}

	static void Select(const char* buffer);

	void DrawAddress(adrs_t adrs, eDisplayStyle display_style, eInteractions interactions);
	// void DrawAddress( adrs_t adrs );
	void DrawAddress(const Line& l);

	void DrawByte(uint8_t byte, eDisplayStyle display_style, eInteractions interactions, adrs_t adrs);
	void DrawByte(uint8_t b, adrs_t adrs); // obsolete
	void DrawBytes(const Line& l, eDisplayStyle display_style, eInteractions interactions);

	void AddPanel(std::unique_ptr<Panel> panel)
	{
		panels_.push_back(std::move(panel));
	}

	void update_adrs_panel( adrs_t adrs )
	{
		adrs_inspector_ = std::make_unique<AdrsInspectorPanel>(*this, adrs);
		adrs_inspector_->unique();
	}

	void update_code_panel( adrs_t adrs )
	{
		// code_inspector_ = std::make_unique<CodeInspectorPanel>(*this, 0);
		code_inspector_->scroll_to_adrs(adrs);
		// code_inspector_->unique();
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

	void Run();

	//  Theme support
	ImFont* large_font() const { return large_font_; }
	ImFont* tiny_font() const { return tiny_font_; }
	const Explorer& explorer() const { return explorer_; }
	void close_panels()
	{
		panels_.erase(std::remove_if(panels_.begin(), panels_.end(), [](const std::unique_ptr<Panel>& p)
		                  { return !p->is_open(); }),
		    panels_.end());
	}

private:
	Explorer& explorer_;

	void InitImgUI();
	void ShutdownImgUI();

	SDL_Window* window = NULL;
	SDL_GLContext gl_context;

	ImFont* tiny_font_;
	ImFont* large_font_;

	//  If true, click follows links
	bool link_ = false;

	//  Inspectors
	std::unique_ptr<CodeInspectorPanel> code_inspector_;
	std::unique_ptr<Panel> byte_inspector_;
	std::unique_ptr<Panel> adrs_inspector_;
	std::unique_ptr<Panel> data_inspector_panel_;

	std::vector<std::unique_ptr<Panel>> panels_;

	Disassembly disassembly_;

	// bool hoover_[65536];
	int hoover_tag_;
	adrs_t hoover_adrs_; //  Hoover is single address

	//  If not empty, we remove this label after the next draw
	std::string remove_label_;

};
