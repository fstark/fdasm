#pragma once

#include "panel.h"

//  A panel that *inspects* a specific piece of data
//  TODO: Such panels could have some sort of history to move accross different data
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
