#pragma once

#include "common.h"
#include <memory>
#include <vector>

using namespace std::literals::string_literals;

class Span
{
public:
	typedef enum
	{
		kMnemonic,
		kRegister,
		kAddress,
		kByte,
		kPseudo,
		kString,
		kText,
		kExpression,
		kLabel
	} SpanType;

private:
	SpanType type_;
	std::string content_;
	adrs_t adrs_ = 0; // Just for hack

public:
	Span(SpanType type, const std::string& text)
	    : type_{ type }
	    , content_{ text }
	{
	}

	Span(SpanType type, const std::string& text, adrs_t adrs)
	    : type_{ type }
	    , content_{ text }
	    , adrs_{ adrs }
	{
	}

	SpanType get_type() const { return type_; } // unused

	const std::string& content() const
	{
		return content_;
	}

	adrs_t adrs() const { return adrs_; }

	static Span mnemonic(const char* text)
	{
		return { kMnemonic, text };
	}

	static Span reg(const char* text)
	{
		return { kRegister, text };
	}

	static Span reg(char reg)
	{
		char buffer[2] = { reg, 0 };
		return { kRegister, buffer };
	}

	static Span text(const char* text)
	{
		return { kText, text };
	}

	static Span adrs(adrs_t adrs)
	{
		char buffer[6];
		snprintf(buffer, 6, "%04XH", adrs);
		return { kAddress, buffer, adrs };
	}

	static Span byte(adrs_t data)
	{
		char buffer[4];
		snprintf(buffer, 4, "%02XH", data);
		return { kByte, buffer };
	}

	static Span pseudo(const char* text)
	{
		return { kPseudo, text };
	}

	static Span string(const char* str)
	{
		return { kString, "\""s + str + "\""s };
	}

	static Span expression(const char* str)
	{
		return { kExpression, str };
	}

	static Span label(const char* str)
	{
		return { kLabel, str };
	}
};

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

	virtual std::vector<Span> emit(size_t max_len) = 0;
};

class CodeEmitter : public Emitter
{
public:
	CodeEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

class DataEmitter : public Emitter
{
public:
	DataEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

class DataWEmitter : public Emitter
{
public:
	DataWEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

class StrzEmitter : public Emitter
{
public:
	StrzEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

class StrF2Emitter : public Emitter
{
public:
	StrF2Emitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

class Str8sEmitter : public Emitter
{
public:
	Str8sEmitter(Disassembler& disassembler)
	    : Emitter(disassembler)
	{
	}

	std::vector<Span> emit(size_t max_len) override;
};

#include "annotations.h"
#include <iostream>

class Line
{
	bool empty_ = true;

	const std::vector<uint8_t>& bytes_; // I don't think we want this (only the offsets)

public:
	adrs_t start_adrs_;
	adrs_t end_adrs_;

	std::vector<Span> content_;

	uint8_t get_byte(int offset) const { return bytes_[start_adrs_ + offset]; } // #### issue with ROM OFFSET
	int byte_count() const { return end_adrs_ - start_adrs_ + 1; }

	Line(const std::vector<uint8_t>& bytes, adrs_t start_adrs, adrs_t end_adrs)
	    : empty_{ false }
	    , bytes_{ bytes }
	    , start_adrs_{ start_adrs }
	    , end_adrs_{ end_adrs }
	{
	}

	Line(const std::vector<uint8_t>& bytes, adrs_t start_adrs)
	    : empty_{ true }
	    , bytes_{ bytes }
	    , start_adrs_{ start_adrs }
	    , end_adrs_{ start_adrs } // #### Or -1
	{
	}

	bool is_empty() const { return empty_; }

	const std::vector<Span> spans() const { return content_; }

	// void add( const char *text, Span::SpanType type=Span::SpanType::kText )
	// {
	// 	content_.push_back( Span{ type, text } );
	// }

	void set_spans(std::vector<Span>& vec)
	{
		content_.insert(content_.end(), vec.begin(), vec.end());
	}
};

class Disassembly
{
	std::vector<Line> lines_;

public:
	Disassembly() = default;

	Disassembly(std::vector<Line>& lines)
	    : lines_{ lines }
	{
	}

	Disassembly(std::vector<Line>&& lines)
	    : lines_{ std::move(lines) }
	{
	}

	const std::vector<Line>& lines() const { return lines_; }

	size_t adrs_to_line(adrs_t adrs) const
	{
		for (size_t i = 0; i < lines_.size(); i++)
		{
			if (lines_[i].start_adrs_ <= adrs && lines_[i].end_adrs_ >= adrs)
				return i;
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
	Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs, std::shared_ptr<Annotations> rom_content);

	~Disassembler()
	{
		std::clog << "Adieu, cruel world!" << std::endl;
	}

	Disassembly disassemble();

	uint8_t read_byte();

	void unread() { --current_; }

	uint16_t read_word();

	adrs_t adrs() const { return current_; }

	adrs_t get_offset() const { return dest_adrs_; }

	void dump();

private:
	const std::vector<uint8_t> bytes_;
	adrs_t current_ = 0;
	adrs_t dest_adrs_;

	std::shared_ptr<Annotations> rom_content_;

	std::unique_ptr<Emitter> _emitters[Annotations::kCOUNT];

	std::vector<Line> lines_;

	Line disassemble_one_instruction(Annotations::RegionType type, adrs_t end_adrs);
	void disassemble_type(Annotations::RegionType type, adrs_t end_adrs);
	void disassemble_label(const Label& l);


};
