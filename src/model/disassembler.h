#pragma once

#include "common.h"
#include <memory>
#include <vector>
#include "rom.h"
#include "annotations.h"
#include <iostream>

#include "line.h"
#include "utils.h"

class Disassembler;

class Emitter
{
public:
	Disassembler& disassembler_;

	Emitter(Disassembler& disassembler)
	    : disassembler_(disassembler)
	{
	}

	virtual ~Emitter() = default;

	virtual void emit(size_t max_len) = 0;
};

class CodeEmitter : public Emitter
{
public:
	CodeEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

class DataEmitter : public Emitter
{
public:
	DataEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

class DataWEmitter : public Emitter
{
public:
	DataWEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

class StrzEmitter : public Emitter
{
public:
	StrzEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

class StrF2Emitter : public Emitter
{
public:
	StrF2Emitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

class Str8sEmitter : public Emitter
{
public:
	Str8sEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	void emit(size_t max_len) override;
};

#include "cpuinfo.h"

class Disassembly
{
	std::vector<Line*> lines_;	//	#### Should be unique_ptr

public:
	Disassembly() = default;

	Disassembly(std::vector<Line*>& lines)
	    : lines_{ lines }
	{
	}

	Disassembly(std::vector<Line*>&& lines)
	    : lines_{ std::move(lines) }
	{
	}

	const std::vector<Line*>& lines() const { return lines_; }

	size_t adrs_to_line(adrs_t adrs) const
	{

		for (size_t i = 0; i < lines_.size(); i++)
		{
			if (lines_[i]->start_adrs() <= adrs && lines_[i]->end_adrs() >= adrs)
			{
				return i;
			}
		}

		return 0;
	}
};

//	I think the disassembler should hold the lines
//	or return some sort of Disassembly object
//	(so we don't scan the vector<Line> for content)
class Disassembler
{
public:
	Disassembler(const Rom &rom, const Annotations &rom_content, const CPUInfo& cpuinfo);

	~Disassembler() {}

	Disassembly disassemble();

	CPUInfo &cpu_info() { return cpu_info_; }

	uint8_t read_byte();

	bool finished() const { return current_ > rom_.last_adrs(); }

	void unread() { --current_; }

	uint16_t read_word();

	adrs_t adrs() const { return current_; }

	void dump();

	void add_instruction( const Instruction &instruction, adrs_t start_adrs, adrs_t end_adrs )
	{
		InstructionLine *line = new InstructionLine( rom_, start_adrs, instruction, 0, 0 );
		auto bytes = rom_.get_bytes( start_adrs, end_adrs - start_adrs + 1 );
		line->set_bytes( bytes );
		lines_.emplace_back(line);
	}

	void add_instruction( const Instruction &instruction, adrs_t start_adrs, adrs_t end_adrs, uint8_t byte )
	{
		InstructionLine *line = new InstructionLine( rom_, start_adrs, instruction, byte, 0 );
		auto bytes = rom_.get_bytes( start_adrs, end_adrs - start_adrs + 1 );
		line->set_bytes( bytes );
		lines_.emplace_back(line);
	}

	void add_instruction( const Instruction &instruction, adrs_t start_adrs, adrs_t end_adrs, adrs_t adrs )
	{
		InstructionLine *line = new InstructionLine( rom_, start_adrs, instruction, 0, adrs );
		auto bytes = rom_.get_bytes( start_adrs, end_adrs - start_adrs + 1 );
		line->set_bytes( bytes );
		lines_.emplace_back(line);
	}

	void add_comment(const std::string& comment)
	{
		CommentLine *line = new CommentLine(rom_, current_, comment);
		lines_.emplace_back(line);
	}

	void add_label(const Label& label)
	{
		LabelLine *line = new LabelLine(rom_, label);
		lines_.emplace_back(line);
	}

	void add_db( adrs_t start_adrs, const std::vector<uint8_t> &data )
	{
		DBDirectiveLine *line = new DBDirectiveLine(rom_, start_adrs, data);
		auto bytes = rom_.get_bytes( start_adrs, data.size() );
		line->set_bytes( bytes );
		lines_.emplace_back(line);
	}

	void add_dw( adrs_t start_adrs, const std::vector<adrs_t> &data )
	{
		DWDirectiveLine *line = new DWDirectiveLine(rom_, start_adrs, data);
		auto bytes = rom_.get_bytes( start_adrs, data.size()*2 );
		line->set_bytes( bytes );
		lines_.emplace_back(line);
	}

	//	Adds a string definition
	//	If the string is larger than 8 characters
	// 	we will add additional blank lines to hold the bytes
	void add_ds( adrs_t start_adrs, const std::string &str )
	{
		DSDirectiveLine *line = new DSDirectiveLine(rom_, start_adrs, str);
		Line * l = line;

		auto adrs = start_adrs;
		int len = str.size()+1;

		while (len>0)
		{
			int count = std::min(8, len);
			auto bytes = rom_.get_bytes( adrs, count );
			l->set_bytes( bytes );
			lines_.emplace_back(l);
			adrs += count;
			len -= count;
			l = new BlankLine(rom_, adrs);
		}

		if (l!=line)
			delete l;	//	We never added this one
	}

	void add_blank( adrs_t start_adrs )
	{
		BlankLine *line = new BlankLine(rom_, start_adrs);
		lines_.emplace_back(line);
	}

private:
	const Rom &rom_;
	adrs_t current_ = 0;
	const Annotations &annotations_;
	CPUInfo cpu_info_;


public:
	std::unique_ptr<Emitter> _emitters[Annotations::kCOUNT];

protected:
	std::vector<Line *> lines_;

	void disassemble_one_instruction(Annotations::RegionType type, adrs_t end_adrs);
	void disassemble_type(Annotations::RegionType type, adrs_t end_adrs);
	void disassemble_label(const Label& l);
};
