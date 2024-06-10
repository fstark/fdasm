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
		kDATA,
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

class StrzEmitter : public Emitter
{
public:
	StrzEmitter(Disassembler& disassembler) : Emitter(disassembler)
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

    uint16_t read_word();

	adrs_t adrs() const { return _current; }

    void disassemble_strz();

    void disassemble_instruction();
};
