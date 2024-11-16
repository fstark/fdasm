#pragma once

#include "panel.h"

class Modal : public Panel
{
public:
	Modal(UI& ui)
	    : Panel(ui)
	{
		title_ = "";
	}

	void draw() override;
	void do_draw() override {} // not used. prob wrong hierarchy.
	virtual void do_draw_content() = 0;
	virtual bool apply()         = 0;

protected:
	bool first_open_ = true;
	bool disable_enter_ = false;
};

class LabelEditModal : public Modal
{
public:
	LabelEditModal(UI& ui, adrs_t adrs, const std::string& label, bool edit_adrs );
	void do_draw_content() override;
	bool apply() override;

private:
	adrs_t adrs_;
	bool edit_adrs_;
	char adrs_buffer_[16];
	Annotations::RegionType label_type_;
	char name_buffer_[128];
	char comment_buffer_[16384];
};

class CommentEditModal : public Modal
{
public:
	CommentEditModal(UI& ui, adrs_t adrs );
	void do_draw_content() override;
	bool apply() override;

private:
	adrs_t adrs_;
	char comment_buffer_[1024];
};

class IOEditModal : public Modal
{
public:
	IOEditModal(UI& ui, uint8_t io_adrs );
	void do_draw_content() override;
	bool apply() override;

private:
	uint8_t io_adrs_;
	char name_buffer_[128];
	char comment_buffer_[16384];
};
