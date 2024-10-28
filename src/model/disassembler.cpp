#include "disassembler.h"
#include <cassert>
#include <stdio.h>

#include "label.h"

#define MAX_CODE_LEN 256000

std::vector<Span> CodeEmitter::emit(size_t)
{
	// char buffer[MAX_CODE_LEN+1];
	// char *p = buffer;

	static const char* register_names = "BCDEHLMA";
	static const char* arith_names[]  = { "ADD", "ADC", "SUB", "SBB", "ANA", "XRA", "ORA", "CMP" };
	// static const char *jump_names[] = { "JNZ", "JP", "JM", "JPE", "JC", "JPO", "JNC", "JPE" };
	static const char* flag_names[]      = { "NZ", "Z", "NC", "C", "PO", "PE", "P", "M" };
	static const char* register_names3[] = { "B", "D", "H", "PSW" };

	// p += snprintf( p, MAX_CODE_LEN, "%04XH ", disassembler_.adrs() );

	uint8_t opcode = disassembler_.read_byte();

	// p += snprintf( p, MAX_CODE_LEN,"%02XH ", opcode );

	int quadrant = (opcode & 0xc0) >> 6;
	int x        = (opcode & 0x07);
	int y        = (opcode & 0x38) >> 3;

	if (quadrant == 0)
	{
		static const char* register_names2[] = { "B", "D", "H", "SP" };

		if (x == 0)
		{
			static const char* instr_00[] = { "NOP", "[DSUB]", "[ARHL]", "[RDEL]", "RIM", "[LDHI r8]", "SIM", "[LDSI r8]" };
			return { Span::mnemonic(instr_00[y]) };
		}
		if (x == 1)
		{
			if (y % 2 == 0)
			{
				return {
					Span::mnemonic("LXI"),
					Span::reg(register_names2[y / 2]),
					Span::text(","),
					Span::adrs(disassembler_.read_word())
				};
			}
			else
			{
				return {
					Span::mnemonic("DAD"),
					Span::reg(register_names2[y / 2])
				};
			}
		}
		if (x == 2)
		{
			if (y < 4)
			{
				static const char* instr_2a[] = { "STAX B", "LDAX B", "STAX D", "LDAX D" };
				return { Span::mnemonic(instr_2a[y]) }; // #### wrong, separate regs?
			}
			else
			{
				static const char* instr_2b[] = { "SHLD", "LHLD", "STA", "LDA" };
				return {
					Span::mnemonic(instr_2b[y - 4]),
					Span::adrs(disassembler_.read_word() + disassembler_.get_offset())
				};
			}
		}
		if (x == 3)
		{
			return {
				Span::mnemonic(y % 1 ? "DCX" : "INX"),
				Span::reg(register_names2[y / 2])
			};
		}
		if (x == 4)
		{
			// INR
			return {
				Span::mnemonic("INR"),
				Span::reg(register_names[y])
			};
		}
		if (x == 5)
		{
			// DCR
			return {
				Span::mnemonic("DCR"),
				Span::reg(register_names[y])
			};
		}
		if (x == 6)
		{
			// MVI
			return {
				Span::mnemonic("MVI"),
				Span::reg(register_names[y]),
				Span::text(","),
				Span::byte(disassembler_.read_byte())
			};
		}
		if (x == 7)
		{
			static const char* instr_07[] = { "RLC", "RRC", "RAL", "RAR", "DAA", "CMA", "STC", "CMC" };
			return {
				Span::mnemonic(instr_07[y])
			};
		}
	}

	if (quadrant == 1)
	{ //	MOV
		int src = (opcode & 0x38) >> 3;
		int dst = (opcode & 0x07);
		// p += snprintf( p, MAX_CODE_LEN, "MOV %c,%c",register_names[src],register_names[dst]);
		return {
			Span::mnemonic("MOV"),
			Span::reg(register_names[src]),
			Span::text(","),
			Span::reg(register_names[dst])
		};
	}
	if (quadrant == 2)
	{ // arith
		// p += snprintf( p, MAX_CODE_LEN, "%s %c",arith_names[y],register_names[x]);
		return {
			Span::mnemonic(arith_names[y]),
			Span::reg(register_names[x])
		};
	}

	if (quadrant == 3)
	{
		if (x == 0)
		{
			// Rxx
			char mnem[16];
			snprintf(mnem, 16, "R%s", flag_names[y]);
			return {
				Span::mnemonic(mnem)
			};
		}
		if (x == 1)
		{
			static const char* instr_31[] = { "POP B", "RET", "POP D", "[SHLX]", "POP H", "PCHL", "POP PSW", "SPHL" };
			// p += snprintf( p, MAX_CODE_LEN,"%s", instr_31[y] );
			return {
				Span::mnemonic(instr_31[y])
			};
		}
		if (x == 2)
		{ // control flow
			char mnem[16];
			snprintf(mnem, 16, "J%s", flag_names[y]);
			// p += snprintf( p, MAX_CODE_LEN, "J%s $%04X",flag_names[y],disassembler_.read_word());
			return {
				Span::mnemonic(mnem),
				Span::adrs(disassembler_.read_word())
			};
		}
		if (x == 3)
		{
			if (y == 0)
			{
				// p += snprintf( p, MAX_CODE_LEN, "JMP $%04X",disassembler_.read_word());
				return {
					Span::mnemonic("JMP"),
					Span::adrs(disassembler_.read_word())
				};
			}
			else if (y == 1)
			{
				// p += snprintf( p, MAX_CODE_LEN, "[RSTV]");
				return {
					Span::mnemonic("[RSTV]")
				};
			}
			else if (y == 2)
			{
				// p += snprintf( p, MAX_CODE_LEN, "OUT %02XH",disassembler_.read_byte());
				return {
					Span::mnemonic("OUT"),
					Span::byte(disassembler_.read_byte())
				};
			}
			else if (y == 3)
			{
				// p += snprintf( p, MAX_CODE_LEN, "IN %02XH",disassembler_.read_byte());
				return {
					Span::mnemonic("IN"),
					Span::byte(disassembler_.read_byte())
				};
			}
			else if (y == 4)
			{
				// p += snprintf( p, MAX_CODE_LEN, "XTHL");
				return {
					Span::mnemonic("XTHL")
				};
			}
			else if (y == 5)
			{
				// p += snprintf( p, MAX_CODE_LEN, "SPHL");
				return {
					Span::mnemonic("XCHG")
				};
			}
			else if (y == 6)
			{
				// p += snprintf( p, MAX_CODE_LEN, "DI");
				return {
					Span::mnemonic("DI")
				};
			}
			else if (y == 7)
			{
				// p += snprintf( p, MAX_CODE_LEN, "EI");
				return {
					Span::mnemonic("EI")
				};
			}
			return {
				Span::mnemonic("??? ")
			};
		}
		if (x == 4)
		{
			// p += snprintf( p, MAX_CODE_LEN, "C%s $%04X",flag_names[y],disassembler_.read_word());
			char mnem[16];
			snprintf(mnem, 16, "C%s", flag_names[y]);
			return {
				Span::mnemonic(mnem),
				Span::adrs(disassembler_.read_word())
			};
		}
		if (x == 5)
		{
			// PUSH

			static const char* instr_35b[] = { "CALL", "[JHLX]", "[LHLX]", "[JK]" };

			if (y % 2 == 0)
				// p += snprintf( p, MAX_CODE_LEN, "PUSH %s",register_names3[y/2]);
				return {
					Span::mnemonic("PUSH"),
					Span::reg(register_names3[y / 2])
				};
			else
				// p += snprintf( p, MAX_CODE_LEN, "%s $%04X", instr_35b[y/2], disassembler_.read_word());
				return {
					Span::mnemonic(instr_35b[y / 2]),
					Span::adrs(disassembler_.read_word())
				};
		}
		if (x == 6)
		{
			static const char* instr_36[8] = { "ADI", "ACI", "SUI", "SBI", "ANI", "XRI", "ORI", "CPI" };
			// p += snprintf( p, MAX_CODE_LEN,"%s %02XH", instr_36[y], disassembler_.read_byte() );
			return {
				Span::mnemonic(instr_36[y]),
				Span::byte(disassembler_.read_byte())
			};
		}
		if (x == 7)
		{
			//	RST
			// p += snprintf( p, MAX_CODE_LEN, "RST %02XH",y);
			return {
				Span::mnemonic("RST"),
				Span::byte(y) //	Should be addressable to y*8
			};
		}
	}

	// p += snprintf( p, MAX_CODE_LEN, " ??? %02X %d %d %d", opcode, quadrant, x, y);

	return {
		Span::mnemonic("???")
	};
}

std::vector<Span> DataEmitter::emit(size_t max_len)
{
	std::vector<Span> res;
	// char buffer[MAX_CODE_LEN+1];
	// char *p = buffer;

	if (max_len > 8)
		max_len = 8;

	// p += snprintf( p, MAX_CODE_LEN, "DB ");
	res.push_back(Span::pseudo("DB"));

	while (max_len--)
	{
		// p += snprintf( p, MAX_CODE_LEN, "%s%02XH", sep, disassembler_.read_byte());
		res.push_back(Span::byte(disassembler_.read_byte()));
	}

	return res;
}

std::vector<Span> DataWEmitter::emit(size_t)
{
	std::vector<Span> res;
	// char buffer[MAX_CODE_LEN+1];
	// char *p = buffer;

	// p += snprintf( p, MAX_CODE_LEN, "DW ");
	res.push_back(Span::pseudo("DW"));
	// p += snprintf( p, MAX_CODE_LEN, "%04XH", disassembler_.read_word());
	res.push_back(Span::adrs(disassembler_.read_word()));
	// p += snprintf( p, MAX_CODE_LEN,"" );

	return res;
}

std::vector<Span> StrzEmitter::emit(size_t)
{
	std::vector<Span> res;

	res.push_back(Span::pseudo("DB"));
	char buffer[32789];
	char* p = buffer;
	while ((*p++ = disassembler_.read_byte()) != 0);

	//	Incorrect, some characters may not be printable
	res.push_back(Span::string(buffer));
	res.push_back(Span::byte(0)); // #### Should be formated in decimal 0

	return res;
}

std::vector<Span> StrF2Emitter::emit(size_t)
{
	std::vector<Span> res;
	char buffer[16];
	// char *p = buffer;

	// p += snprintf( p, MAX_CODE_LEN, "DB \"%c%c\"",disassembler_.read_byte(),disassembler_.read_byte());
	res.push_back(Span::pseudo("DB"));
	uint8_t c0 = disassembler_.read_byte();
	uint8_t c1 = disassembler_.read_byte();
	snprintf(buffer, 16, "%c%c", c0, c1);
	res.push_back(Span::string(buffer));

	return res;
}

std::vector<Span> Str8sEmitter::emit(size_t)
{
	std::vector<Span> res;
	char buffer[16];

	res.push_back(Span::pseudo("DB"));
	snprintf(buffer, 16, "80H or '%c'", disassembler_.read_byte() & 0x7f);
	res.push_back(Span::expression(buffer));
	res.push_back(Span::text(","));

	uint8_t c;

	char buf2[32768];
	char* p = buf2;
	while ((c = disassembler_.read_byte()) < 0x80)
		// p += snprintf( p, MAX_CODE_LEN, "%c", c);
		*p++ = c;

	*p = 0;

	// p += snprintf( p, MAX_CODE_LEN, "\"");
	disassembler_.unread();

	res.push_back(Span::string(buf2));

	return res;
}

Disassembler::Disassembler(const std::vector<uint8_t>& bytes, adrs_t adrs, std::shared_ptr<Annotations> rom_content)
    : bytes_(bytes)
    , dest_adrs_(adrs)
    , rom_content_(rom_content)
    , _emitters{
	    std::make_unique<CodeEmitter>(*this),
	    std::make_unique<CodeEmitter>(*this),
	    std::make_unique<StrzEmitter>(*this),
	    std::make_unique<Str8sEmitter>(*this),
	    std::make_unique<StrF2Emitter>(*this),
	    std::make_unique<DataEmitter>(*this),
	    std::make_unique<DataWEmitter>(*this)
    }
{
}

uint8_t Disassembler::read_byte()
{
	assert(current_ < bytes_.size());
	return bytes_[current_++];
}

uint16_t Disassembler::read_word()
{
	uint16_t word = bytes_[current_] | (bytes_[current_ + 1] << 8);
	current_ += 2;
	return word;
}

// std::string Disassembler::disassemble_strz()
// {
// 	char buffer[MAX_CODE_LEN+1];
// 	char *p = buffer;

//     p += snprintf( p, MAX_CODE_LEN, "DB \"");
// 	uint8_t c;
//     while ((c=read_byte()) != 0)
//         p += snprintf( p, MAX_CODE_LEN, "%c", c);
//     p += snprintf( p, MAX_CODE_LEN, "\",00H");

// 	return buffer;
// }

Line Disassembler::disassemble_one_instruction(Annotations::RegionType type, adrs_t end_adrs)
{
	auto adrs = current_;
	//	Lets look at the size (limited to 8 bytes)
	int size = end_adrs - adrs + 1;
	if (size > 8)
		size = 8;

	auto spans = _emitters[type]->emit(size);
	adrs_t end = current_ - 1;

	if (end > end_adrs)
	{
		//	The instruction did not fit in the region
		//	We finish the disassembly with a DB
		current_ = adrs;
		return disassemble_one_instruction(Annotations::kDATA, end_adrs);
	}

	Line l{ bytes_, adrs, end };
	l.set_spans(spans);

	return l;
}

void Disassembler::disassemble_type(Annotations::RegionType type, adrs_t end_adrs)
{
	while (current_ <= end_adrs)
	{
		auto l = disassemble_one_instruction(type, end_adrs);
		lines_.push_back(l);
	}
}

void Disassembler::disassemble_label(const Label& l)
{
	Line label{ bytes_, l.start_adrs() };
	std::vector<Span> label_spans = { Span::label(l.name().c_str()) };
	label.set_spans(label_spans);
	lines_.push_back(label);
	current_ = l.start_adrs();

	disassemble_type(l.type(), l.end_adrs());
}

Disassembly Disassembler::disassemble()
{
	lines_.clear();

	for (auto& l : rom_content_->get_labels())
	{
		disassemble_label(l);
	}

	return Disassembly(std::move(lines_));
}

void Disassembler::dump()
{
	std::clog << "Dumping disassembler state" << (void*)this << std::endl;
	std::clog << "Current address: " << current_ << std::endl;
	std::clog << "Destination address: " << dest_adrs_ << std::endl;
	std::clog << "Data size: " << bytes_.size() << std::endl;
}
