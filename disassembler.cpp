#include "disassembler.h"
#include <stdio.h>

RomContents::SectionType RomContents::get_section(adrs_t adrs)
{
	if (adrs == 3)
		return kSTRZ;
	return kCODE;
}

void CodeEmitter::emit()
{
	static const char *register_names = "BCDEHLMA";
	static const char *arith_names[] = { "ADD", "ADC", "SUB", "SBB", "ANA", "XRA", "ORA", "CMP" };
	// static const char *jump_names[] = { "JNZ", "JP", "JM", "JPE", "JC", "JPO", "JNC", "JPE" };
	static const char *flag_names[] = { "NZ", "Z", "NC", "C", "PO", "PE", "P", "M" };

	printf( "%04XH ", _disassembler.adrs() );

	uint8_t opcode = _disassembler.read_byte();

	int quadrant = (opcode&0xc0)>>6;

	if (quadrant==1)
	{	//	MOV
		int src = (opcode&0x38)>>3;
		int dst = (opcode&0x07);
		printf("\tMOV %c,%c\n",register_names[src],register_names[dst]);
		return;
	}
	if (quadrant==2)
	{	// arith
		int instr = (opcode&0x38)>>3;
		int reg = (opcode&0x07);
		printf("\t%s %c\n",arith_names[instr],register_names[reg]);
		return;
	}

	if (quadrant==3)
	{
		int instr = opcode&0x7;
		if (instr==2)
		{	// control flow
			int flag = (opcode&0x38)>>3;
			printf("\tJ%s $%04X\n",flag_names[flag],_disassembler.read_word());
			return;
		}
	}

	switch (opcode)
	{
		case 0xc2:
			printf("\tJNZ $%04X\n", _disassembler.read_word());
			break;
		case 0xc3:
			printf("\tJMP $%04X\n", _disassembler.read_word());
			break;
		case 0xe3:
			printf("\tXTHL\n");
			break;
		default:
			printf("\t ??? %02X\n", opcode);
	}
}

void DataEmitter::emit()
{
	printf("\tDB ");
		printf("%02XH,", _disassembler.read_byte());
	printf( "\n" );
}

void StrzEmitter::emit()
{
	printf("\tDB \"");
	uint8_t c;
	while (c =_disassembler.read_byte()!= 0)
		printf("%c", c);
	printf("\",00H\n");
}

Disassembler::Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs) 
    : _bytes(bytes), _dest_adrs(adrs), _emitters{
        std::make_unique<CodeEmitter>(*this),
        std::make_unique<StrzEmitter>(*this),
        std::make_unique<DataEmitter>(*this)
    } {}

void Disassembler::disassemble()
{
    while (_current < _bytes.size())
        if (_current == 3)
            disassemble_strz();
        else
            disassemble_instruction();
}

uint8_t Disassembler::read_byte()
{
    return _bytes[_current++];
}

uint16_t Disassembler::read_word()
{
    uint16_t word = _bytes[_current] | (_bytes[_current + 1] << 8);
    _current += 2;
    return word;
}

void Disassembler::disassemble_strz()
{
    printf("\tDB \"");
	uint8_t c;
    while ((c=read_byte()) != 0)
        printf("%c", c);
    printf("\",00H\n");
}

void Disassembler::disassemble_instruction()
{
    auto section = _rom_content.get_section( _current );

	_emitters[section]->emit();
}
