#pragma once

#include "panel.h"

class Modal : public Panel
{
protected:
	bool first_open_ = true;

public:
	Modal(UI& ui)
	    : Panel(ui)
	{
		title_ = "";
	}

	void DoDraw() override;
	virtual void DoDrawContent() = 0;
	virtual void Apply()         = 0;
};

class LabelEditModal : public Modal
{
	adrs_t adrs_;
	Annotations::RegionType label_type_;

	char name_buffer_[128];

public:
	LabelEditModal(UI& ui, adrs_t adrs, const std::string& /* label */)
	    : Modal(ui)
	    , adrs_{ adrs }
	{
		title_          = "Edit Label";
		name_buffer_[0] = 0;
		Label* lbl      = Annotations::label_from_adrs(adrs);
		label_type_     = Annotations::kCODE;
		if (lbl)
		{
			snprintf(name_buffer_, 128, "%s", lbl->name().c_str());
			label_type_ = lbl->type();
		}
	}

	void DoDrawContent() override;
	void Apply() override;
};
