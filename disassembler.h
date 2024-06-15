#include <vector>
#include <cstdint>
#include <memory>

typedef uint16_t adrs_t;

class RomContents
{
public:
	typedef enum
	{
		kCODE,
		kSTRZ,
		kSTR8S,
		kSTRF2,
		kDATA,
		kDATAW,
		kCOUNT
	} SectionType;

	SectionType get_section(adrs_t adrs);
};

class Disassembler;

class Emitter
{
public:
	Disassembler& _disassembler;

	Emitter(Disassembler& disassembler) : _disassembler(disassembler)
	{
	}

	virtual ~Emitter() = default;

	virtual void emit() = 0;
};

class CodeEmitter : public Emitter
{
public:
	CodeEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class DataEmitter : public Emitter
{
public:
	DataEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class DataWEmitter : public Emitter
{
public:
	DataWEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class StrzEmitter : public Emitter
{
public:
	StrzEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class StrF2Emitter : public Emitter
{
public:
	StrF2Emitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class Str8sEmitter : public Emitter
{
public:
	Str8sEmitter(Disassembler& disassembler) : Emitter(disassembler)
	{
	}

	void emit() override;
};

class Disassembler
{
    const std::vector<uint8_t>& _bytes;
    adrs_t _current = 0;
    adrs_t _dest_adrs;

    std::unique_ptr<Emitter> _emitters[RomContents::kCOUNT];

    RomContents _rom_content;

public:
    Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs);

    void disassemble();

    uint8_t read_byte();

	void unread() { --_current; }

    uint16_t read_word();

	adrs_t adrs() const { return _current; }

	adrs_t get_offset() const { return _dest_adrs; }

    void disassemble_strz();

    void disassemble_instruction();
};
