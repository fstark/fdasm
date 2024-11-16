#pragma once

#include "inspector.h"

class Comment;

#include "line.h"

class CodeInspectorPanel : public InspectorPanel<adrs_t>, DefaultLineVisitor
{
public:
	CodeInspectorPanel(UI& ui, adrs_t data);
	void do_draw_data() override;
	void scroll_to_line(int line);
	void scroll_to_adrs(int adrs);

	//	Preview 8 lines of code from adrs
	void code_preview( adrs_t adrs, int count = 8 );

protected:
	void data_changed() override;

	//	#### Lacks auto-scrolling
	//	Maybe capture the top-line at each frame and copy it?
	std::unique_ptr<InspectorPanel<adrs_t>> duplicate() const override
	{
		auto res = std::make_unique<CodeInspectorPanel>(ui_,data());
		*res = *this;
		return res;
	}

	void paint_selection_if_needed( const Line &line );
	void draw_line_adrs( const Line &line );
	void draw_line_bytes( const Line &line );


	//	Line visitor
	void will_visit(const Line& line) override;
	void did_visit(const Line& line) override;

	void visit(const OrgDirectiveLine& line) override;
	void visit(const DBDirectiveLine& line) override;
	void visit(const DWDirectiveLine& line) override;
	void visit(const DSDirectiveLine& line) override;
	void visit(const InstructionLine& line) override;
	void visit(const CommentLine& line) override;
	void visit(const LabelLine& line) override;
	void visit(const BlankLine& line) override;

	bool is_hovering_line_;

private:
	int target_line_ = -1; 				//  The line to scroll to (if !=-1)

	eDisplayStyle address_display_style_ = kDisplayHex;
	eDisplayStyle bytes_display_style_   = kDisplayHex;

	int nested_ = 0;
};
