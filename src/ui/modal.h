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

	void do_draw() override;
	virtual void do_draw_content() = 0;
	virtual void apply()         = 0;

protected:
	bool first_open_ = true;
};

class LabelEditModal : public Modal
{
public:
	LabelEditModal(UI& ui, adrs_t adrs, const std::string& /* label */);
	void do_draw_content() override;
	void apply() override;

private:
	adrs_t adrs_;
	Annotations::RegionType label_type_;
	char name_buffer_[128];
};

class CommentEditModal : public Modal
{
public:
	CommentEditModal(UI& ui, adrs_t adrs );
	void do_draw_content() override;
	void apply() override;

private:
	adrs_t adrs_;
	char comment_buffer_[1024];
};
