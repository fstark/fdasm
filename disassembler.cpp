#include "disassembler.h"
#include <stdio.h>

RomContents::SectionType RomContents::get_section(adrs_t adrs)
{
	if (adrs<3)
		return kCODE;
	if (adrs == 3)
		return kSTRZ;
	if (adrs<0x40)
		return kCODE;
	if (adrs<0x80)
		return kDATAW;
	if (adrs<0x261)
		return kSTR8S;
	if (adrs<0x262)
		return kDATA;
	if (adrs<0x2e2)
		return kDATAW;
	if (adrs<0x2f2)
		return kDATA;
	if (adrs<0x31c)
		return kDATAW;
	if (adrs<0x35a)
		return kSTRF2;
	if (adrs<0x360)
		return kDATAW;
	if (adrs<0x36f)
		return kCODE;
	if (adrs<0x3ea)
		return kDATA;
	if (adrs<0x401)
		return kSTRZ;
	return kCODE;
}

void CodeEmitter::emit()
{
	static const char *register_names = "BCDEHLMA";
	static const char *arith_names[] = { "ADD", "ADC", "SUB", "SBB", "ANA", "XRA", "ORA", "CMP" };
	// static const char *jump_names[] = { "JNZ", "JP", "JM", "JPE", "JC", "JPO", "JNC", "JPE" };
	static const char *flag_names[] = { "NZ", "Z", "NC", "C", "PO", "PE", "P", "M" };
	static const char *register_names3[] = {"B","D","H","PSW"};

	printf( "%04XH ", _disassembler.adrs() );

	uint8_t opcode = _disassembler.read_byte();

	printf( "%02XH ", opcode );

	int quadrant = (opcode&0xc0)>>6;
	int x = (opcode&0x07);
	int y = (opcode&0x38)>>3;

	if (quadrant==0)
	{
		static const char *register_names2[] = {"B","D","H","SP"};

		if (x==0)
		{
			static const char *instr_00[] = { "NOP", "[DSUB]", "[ARHL]", "[RDEL]", "RIM", "[LDHI r8]", "SIM", "[LDSI r8]" };
			printf( "\t%s\n", instr_00[y] );
			return ;
		}
		if (x==1)
		{
			if (y%2==0)
			{
				printf( "\tLXI %s,%04XH\n", register_names2[y/2], _disassembler.read_word() );
				return ;
			}
			else
			{
				printf( "\tDAD %s\n", register_names2[y/2] );
				return ;
			}
		}
		if (x==2)
		{
			if (y<4)
			{
				static const char *instr_2a[] = { "STAX B", "LDAX B", "STAX D", "LDAX D" };
				printf( "\t%s\n", instr_2a[y] );
			}
			else
			{
				static const char *instr_2b[] = { "SHLD", "LHLD", "STA", "LDA" };
				printf( "\t%s %04XH\n", instr_2b[y-4], _disassembler.read_word()+_disassembler.get_offset() );
			}
			return ;
		}
		if (x==3)
		{
			printf( "\t%s %s\n", y%1?"INX":"DCX", register_names2[y/2] );
			return ;
		}
		if (x==4)
		{
			// INR
			printf( "\tINR %c\n", register_names[y] );
			return ;
		}
		if (x==5)
		{
			// DCR
			printf( "\tDCR %c\n", register_names[y] );
			return ;
		}
		if (x==6)
		{
			// MVI
			printf( "\tMVI %c,%02XH\n", register_names[y], _disassembler.read_byte() );
			return ;
		}
		if (x==7)
		{
			static const char *instr_07[] = { "RLC", "RRC", "RAL", "RAR", "DAA", "CMA", "STC", "CMC" };
			printf( "\t%s\n", instr_07[y] );
			return ;
		}
	}

	if (quadrant==1)
	{	//	MOV
		int src = (opcode&0x38)>>3;
		int dst = (opcode&0x07);
		printf("\tMOV %c,%c\n",register_names[src],register_names[dst]);
		return;
	}
	if (quadrant==2)
	{	// arith
		printf("\t%s %c\n",arith_names[y],register_names[x]);
		return;
	}

	if (quadrant==3)
	{
		if (x==0)
		{
			// Rxx
			printf("\tR%s\n",flag_names[y]);
			return;
		}
		if (x==1)
		{
			static const char *instr_31[] = { "POP B", "RET", "POP D", "[SHLX]", "POP H", "PCHL", "POP PSW", "SPHL" };
			printf( "\t%s\n", instr_31[y] );
			return ;
		}
		if (x==2)
		{	// control flow
			printf("\tJ%s $%04X\n",flag_names[y],_disassembler.read_word());
			return;
		}
		if (x==3)
		{
			if (y==0)
			{
				printf("\tJMP $%04X\n",_disassembler.read_word());
			}
			else if (y==1)
			{
				printf("\t[RSTV]\n");
			}
			else if (y==2)
			{
				printf("\tOUT %02XH\n",_disassembler.read_byte());
			}
			else if (y==3)
			{
				printf("\tIN %02XH\n",_disassembler.read_byte());
			}
			else if (y==4)
			{
				printf("\tXTHL\n");
			}
			else if (y==5)
			{
				printf("\tSPHL\n");	
			}
			else if (y==6)
			{
				printf("\tDI\n");
			}
			else if (y==7)
			{
				printf("\tEI\n");
			}
			return ;
		}
		if (x==4)
		{
			printf("\tC%s $%04X\n",flag_names[y],_disassembler.read_word());
			return ;
		}
		if (x==5)
		{
			// PUSH

			static const char *instr_35b[] = { "CALL", "[JHLX]", "[LHLX]", "[JK]" };

			if (y%2==0)
				printf("\tPUSH %s\n",register_names3[y/2]);
			else
				printf("\t%s $%04X\n", instr_35b[y/2], _disassembler.read_word());
			return;
		}
		if (x==6)
		{
			static const char *instr_36[8] = { "ADI", "ACI", "SUI", "SBI", "ANI", "XRI", "ORI", "CPI" };
			printf( "\t%s %02XH\n", instr_36[y], _disassembler.read_byte() );
			return ;
		}
		if (x==7)
		{
			//	RST
			printf("\tRST %02XH\n",y);
			return;
		}
	}

	printf("\t ??? %02X %d %d %d\n", opcode, quadrant, x, y);
}

void DataEmitter::emit()
{
	printf("\tDB ");
		printf("%02XH,", _disassembler.read_byte());
	printf( "\n" );
}

void DataWEmitter::emit()
{
	printf("\tDW ");
		printf("%04XH", _disassembler.read_word());
	printf( "\n" );
}

void StrzEmitter::emit()
{
	printf("\tDB \"");
	uint8_t c;
	while ((c=_disassembler.read_byte())!= 0)
		printf("%c", c);
	printf("\",00H\n");
}

void StrF2Emitter::emit()
{
	printf("\tDB \"%c%c\"",_disassembler.read_byte(),_disassembler.read_byte());
}

void Str8sEmitter::emit()
{
	printf("\tDB 80H or '%c',\"",_disassembler.read_byte()&0x7f);
	uint8_t c;
	while ((c=_disassembler.read_byte())<0x80)
		printf("%c", c);
	printf("\"\n");
	_disassembler.unread();
}

Disassembler::Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs) 
    : _bytes(bytes), _dest_adrs(adrs), _emitters{
        std::make_unique<CodeEmitter>(*this),
        std::make_unique<StrzEmitter>(*this),
        std::make_unique<Str8sEmitter>(*this),
		std::make_unique<StrF2Emitter>(*this),
        std::make_unique<DataEmitter>(*this),
        std::make_unique<DataWEmitter>(*this)
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
