#pragma once

#include "inspector.h"

class Modal : public Panel
{
public:
	Modal(UI& ui)
	    : Panel(ui)
	{
		title_ = "";
	}

	void DoDraw() override;
	virtual void DoDrawContent() = 0;
	virtual void Apply()         = 0;

protected:
	bool first_open_ = true;
};

class LabelEditModal : public Modal
{
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

private:
	adrs_t adrs_;
	Annotations::RegionType label_type_;
	char name_buffer_[128];
};
