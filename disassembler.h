#include <vector>
#include <memory>
#include "common.h"

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
		kExpression
	} SpanType;

private:
	SpanType type_;
	std::string content_;

public:
	Span( SpanType type, const std::string &text ) :
		type_{ type },
		content_{ text }
		{}

	SpanType get_type() const { return type_; } // unused

	const std::string &content() const
	{
		return content_;
	}

	static Span mnemonic( const char *text )
	{
		return { kMnemonic, text };
	}

	static Span reg( const char *text )
	{
		return { kRegister, text };
	}

	static Span reg( char reg )
	{
		char buffer[2] = { reg, 0 };
		return { kRegister, buffer };
	}

	static Span text( const char *text )
	{
		return { kText, text };
	}

	static Span adrs( adrs_t adrs )
	{
		char buffer[6];
		snprintf( buffer, 6, "%04XH", adrs );
		return { kAddress, buffer };
	}

	static Span byte( adrs_t data )
	{
		char buffer[4];
		snprintf( buffer, 4, "%02XH", data );
		return { kByte, buffer };
	}

	static Span pseudo( const char *text )
	{
		return { kPseudo, text };
	}

	static Span string( const char *str )
	{
		return { kString, "\""s+str+"\""s };
	}

	static Span expression( const char *str )
	{
		return { kExpression, str };
	}
};

class Disassembler;

class Emitter
{
public:
	Disassembler& disassembler_;

	Emitter(Disassembler& disassembler) : disassembler_(disassembler)
	{
	}

	virtual ~Emitter() = default;

	virtual std::vector<Span> emit( size_t max_len ) = 0;
};

class CodeEmitter : public Emitter
{
public:
	CodeEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

class DataEmitter : public Emitter
{
public:
	DataEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

class DataWEmitter : public Emitter
{
public:
	DataWEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

class StrzEmitter : public Emitter
{
public:
	StrzEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

class StrF2Emitter : public Emitter
{
public:
	StrF2Emitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

class Str8sEmitter : public Emitter
{
public:
	Str8sEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	std::vector<Span> emit( size_t max_len ) override;
};

#include "region.h"
#include <iostream>


class Line
{
    const std::vector<uint8_t> &bytes_;	// I don't think we want this (only the offsets)


public:
	adrs_t start_adrs_;
	adrs_t end_adrs_;
	std::string adrs_;

	std::vector<Span> content_;

	uint8_t get_byte( int offset ) const { return bytes_[start_adrs_+offset]; } // #### issue with ROM OFFSET
	int byte_count() const { return end_adrs_-start_adrs_+1; }

	Line( const std::vector<uint8_t> &bytes, adrs_t start_adrs, adrs_t end_adrs ) :
		bytes_{ bytes },
		start_adrs_{ start_adrs },
		end_adrs_{ end_adrs }
	{
		char buffer[256];
		char *p = buffer;
		
		p += snprintf( p, 256, "%04X:", start_adrs_ );

		const char *sep = "";
		for (auto a = start_adrs_;a<=end_adrs_;a++)
		{
			p += snprintf( p, 256, "%s%02X", sep, bytes[a] );	//	#### Incorrect due to start address of ROM
			sep = " ";
		}
		adrs_ = buffer;
	}

	const std::vector<Span> spans() const { return content_; }

	// void add( const char *text, Span::SpanType type=Span::SpanType::kText )
	// {
	// 	content_.push_back( Span{ type, text } );
	// }

	void set_spans( std::vector<Span> &vec )
	{
		content_.insert(content_.end(), vec.begin(), vec.end());
	}
};

class Disassembler
{
    const std::vector<uint8_t> bytes_;
    adrs_t current_ = 0;
    adrs_t dest_adrs_;

	std::shared_ptr<RomContents> rom_content_;

    std::unique_ptr<Emitter> _emitters[RomContents::kCOUNT];

public:
    Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs, std::shared_ptr<RomContents> rom_content);

	~Disassembler()
	{
		std::clog << "Adieu, cruel world!" << std::endl;
	}

    std::vector<Line> disassemble();

    uint8_t read_byte();

	void unread() { --current_; }

    uint16_t read_word();

	adrs_t adrs() const { return current_; }

	adrs_t get_offset() const { return dest_adrs_; }

    // void disassemble_strz();

    Line disassemble_instruction();

	void dump();
};
