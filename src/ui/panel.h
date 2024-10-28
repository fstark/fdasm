#pragma once

#include "common.h"
#include "label.h"
#include "xrefs.h"
#include <string>

class UI;

//  A panel that is shown by the main loop
class Panel
{
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
};

