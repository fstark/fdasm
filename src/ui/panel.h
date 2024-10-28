#pragma once

#include "common.h"
#include "label.h"
#include "xrefs.h"
#include <string>

class UI;

//  A panel that is shown by the main loop
class Panel
{
protected:
	bool is_open_     = true;
	bool is_closable_ = false;
	bool has_resize   = false;
	UI& ui_;
	std::string title_;
	std::string id_;

	int tag; //  Unique tag, used to manage global hoover

	//  Override to perform the drawing
	virtual void DoDraw() = 0;

public:
	Panel(UI& ui)
	    : ui_{ ui }
	{
		title_ = "";
		id_    = "";

		static int s_tag = 0;
		tag              = s_tag;
		s_tag += 256; //  256 subtag values for multiple hoover spots in inspecter
	}
	virtual ~Panel() {}

	void Draw();

	const std::string name() const { return title_ + "##" + id_; }

	//  All windows with this title will be the same
	void unique(const std::string id = "") { id_ = id; }

	bool is_open() const { return is_open_; }

	void close() { is_open_ = false; }

	void set_closable(bool closable) { is_closable_ = closable; }
};

//  A panel that *inspects* a specific piece of data
//  Such panels can be duplicated
template <class T>
class InspectorPanel : public Panel
{
protected:
	T data_;

public:
	InspectorPanel(UI& ui, T data)
	    : Panel(ui)
	    , data_{ data }
	{
		title_ = "";
		id_    = std::to_string((long)this); //  #### Another Unique ID would be better
	}
};
