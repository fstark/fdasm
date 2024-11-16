#pragma once

#include "common.h"

#include <string>
#include <vector>

#include "rom.h"
#include "label.h"

using namespace std::literals::string_literals;

class Rom;

class Line;
class CommentLine;
class InstructionLine;
class OrgDirectiveLine;
class DBDirectiveLine;
class DWDirectiveLine;
class DSDirectiveLine;
class LabelLine;
class BlankLine;

class LineVisitor
{
    public:
    virtual void will_visit(const Line& line) = 0;
    virtual void did_visit(const Line& line) = 0;
    virtual void visit(const CommentLine& line) = 0;
    virtual void visit(const InstructionLine& line) = 0;
    virtual void visit(const OrgDirectiveLine& line) = 0;
    virtual void visit(const DBDirectiveLine& line) = 0;
    virtual void visit(const DWDirectiveLine& line) = 0;
    virtual void visit(const DSDirectiveLine& line) = 0;
    virtual void visit(const LabelLine& line) = 0;
    virtual void visit(const BlankLine& line) = 0;
};

class DefaultLineVisitor : public LineVisitor
{
    public:
    void will_visit(const Line& ) override {}
    void did_visit(const Line& ) override {}
    void visit(const CommentLine& ) override {}
    void visit(const InstructionLine& ) override {}
    void visit(const OrgDirectiveLine& ) override {}
    void visit(const DBDirectiveLine& ) override {}
    void visit(const DWDirectiveLine& ) override {}
    void visit(const DSDirectiveLine& ) override {}
    void visit(const LabelLine& ) override {}   
    void visit(const BlankLine& ) override {}   
};

//  A line in the proposed disassembly
class Line
{

    public:

    Line(const Rom& rom, adrs_t start_adrs)
        : rom_{ rom }
        , start_adrs_{ start_adrs }
    {
    }

    virtual ~Line() = default;

    virtual void visit( LineVisitor& visitor ) const
    {
        visitor.will_visit(*this);
        do_visit(visitor);
        visitor.did_visit(*this);
    }
    virtual void do_visit( LineVisitor& visitor ) const = 0;

    uint8_t get_byte(int offset) const { return rom_.get(start_adrs_ + offset); }
    int byte_count() const { return bytes_.size(); }

    adrs_t start_adrs() const { return start_adrs_; }
    adrs_t end_adrs() const {
        if (start_adrs_==0 && bytes_.empty())
            return 0; // #### This is wrong, but 0,0 => end of 0xffff because there are 65537 possibilities for empty
        return start_adrs_+bytes_.size()-1;
        }

    bool is_empty() const { return bytes_.empty(); }

    void set_bytes(const std::vector<uint8_t> &bytes) { bytes_ = bytes; }
    const std::vector<uint8_t>& bytes() const { return bytes_; }

protected:

    const Rom& rom_;	// #### This is temporary. Lines should probably copy the bytes they need
                        // (and only the ones they need)

    adrs_t start_adrs_;

    std::vector<uint8_t> bytes_;
};

#include "comment.h"

//  This line displays a single line comment
class CommentLine : public Line
{
    public:
    CommentLine(const Rom& rom, adrs_t start_adrs, const std::string& comment)
        : Line(rom, start_adrs), comment_{ comment }
    {
    }

    const CommentText& comment() const { return comment_; }

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }

    protected:
    CommentText comment_;
};

class Instruction;

//  Contains a single instruction
//  (Unclear how to split)
class InstructionLine : public Line
{
    public:
    InstructionLine(const Rom& rom, adrs_t start_adrs, const Instruction &instruction, uint8_t b, adrs_t w)
        : Line(rom, start_adrs), instruction_{ instruction }, byte_{ b }, word_{ w }
    {
    }

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }

    const Instruction& instruction() const { return instruction_; }

    uint8_t byte() const { return byte_; }
    adrs_t word() const { return word_; }

    protected:
    const Instruction& instruction_;
    uint8_t byte_;
    adrs_t word_;
};

//  An assembler directive
class DirectiveLine : public Line
{
    public:
        // kORG,kDB,kDW,kDS,kEQU,kEND

    DirectiveLine(const Rom& rom, adrs_t start_adrs)
        : Line(rom, start_adrs)
    {
    }
};

class OrgDirectiveLine : public DirectiveLine
{
    public:
    OrgDirectiveLine(const Rom& rom, adrs_t start_adrs, adrs_t adrs)
        : DirectiveLine(rom, start_adrs), adrs_{ adrs } {}

    void do_visit( LineVisitor& visitor ) const { visitor.visit(*this); }
    adrs_t adrs() const { return adrs_; }

    protected:
    adrs_t adrs_;
};

class DBDirectiveLine : public DirectiveLine
{
    public:
    DBDirectiveLine(const Rom& rom, adrs_t start_adrs, const std::vector<uint8_t>& data)
        : DirectiveLine(rom, start_adrs), data_{ data } {}

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }
    const std::vector<uint8_t>& data() const { return data_; }

    protected:
    std::vector<uint8_t> data_;
};

class DWDirectiveLine : public DirectiveLine
{
    public:
    DWDirectiveLine(const Rom& rom, adrs_t start_adrs, const std::vector<adrs_t>& data)
        : DirectiveLine(rom, start_adrs), data_{ data } {}

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }
    const std::vector<adrs_t>& data() const { return data_; }

    protected:
    std::vector<adrs_t> data_;
};

#include "utils.h"

class DSDirectiveLine : public DirectiveLine
{
    public:
    DSDirectiveLine(const Rom& rom, adrs_t start_adrs, const std::string &data)
        : DirectiveLine(rom, start_adrs), unescaped_data_{ data }, data_{escape(data)} {}

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }
    const std::string &data() const { return data_; }
    const std::string &unescaped_data() const { return unescaped_data_; }

    protected:
    std::string unescaped_data_;
    std::string data_;
};



#include "label.h"

//  This line contains a label
class LabelLine : public Line
{
    public:
    LabelLine(const Rom& rom, const Label& label)
        : Line(rom, label.start_adrs()), label_{ &label }
    {
    }
    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }

    const Label& label() const { return *label_; }

    protected:
    const Label *label_;
};

//  Just a blank line
class BlankLine : public Line
{
    public:
    BlankLine(const Rom& rom, adrs_t start_adrs)
        : Line(rom, start_adrs)
    {
    }

    void do_visit( LineVisitor& visitor ) const override { visitor.visit(*this); }
};
