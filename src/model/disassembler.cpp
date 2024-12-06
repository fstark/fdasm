#include "disassembler.h"
#include <cassert>
#include <stdio.h>

#include "label.h"
#include "utils.h"

#define MAX_CODE_LEN 256000

void CodeEmitter::emit(size_t)
{
	adrs_t start_adrs = disassembler_.adrs();

	uint8_t opcode = disassembler_.read_byte();
	const Instruction &instr = disassembler_.cpu_info().instruction(opcode);

	// p += snprintf( p, MAX_CODE_LEN,"%02XH ", opcode );

	int quadrant = (opcode & 0xc0) >> 6;
	int x        = (opcode & 0x07);
	int y        = (opcode & 0x38) >> 3;

	if (quadrant == 0)
	{
		if (x == 0)
		{
			// static const char* instr_00[] = { "NOP", "[DSUB]", "[ARHL]", "[RDEL]", "RIM", "[LDHI r8]", "SIM", "[LDSI r8]" };
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 1)
		{
			if (y % 2 == 0)
			{
				// return {
				// 	Span::mnemonic("LXI"),
				// 	Span::reg(register_names2[y / 2]),
				// 	Span::text(","),
				// 	Span::adrs(disassembler_.read_word())
				// };
				disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
				return ;
			}
			else
			{
				// return {
				// 	Span::mnemonic("DAD"),
				// 	Span::reg(register_names2[y / 2])
				// };
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
		}
		if (x == 2)
		{
			if (y < 4)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
				return ;
			}
		}
		if (x == 3)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 4)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 5)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 6)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs+1, disassembler_.read_byte() );
			return ;
		}
		if (x == 7)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
	}

	if (quadrant == 1)
	{ //	MOV
		disassembler_.add_instruction( instr, start_adrs, start_adrs );
		return ;
	}
	if (quadrant == 2)
	{ // arith
		disassembler_.add_instruction( instr, start_adrs, start_adrs );
		return ;
	}

	if (quadrant == 3)
	{
		if (x == 0)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 1)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
		if (x == 2)
		{ // control flow
			disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
			return ;
		}
		if (x == 3)
		{
			if (y == 0)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
				return ;
			}
			else if (y == 1)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else if (y == 2)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs+1, disassembler_.read_byte() );
				return ;
			}
			else if (y == 3)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs+1, disassembler_.read_byte() );
				return ;
			}
			else if (y == 4)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else if (y == 5)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else if (y == 6)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else if (y == 7)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			assert( false );
		}
		if (x == 4)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
			return ;
		}
		if (x == 5)
		{
			// PUSH
			if (y % 2 == 0)
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs );
				return ;
			}
			else
			{
				disassembler_.add_instruction( instr, start_adrs, start_adrs+2, disassembler_.read_word() );
				return ;
			}
		}
		if (x == 6)
		{
			disassembler_.add_instruction( instr, start_adrs, start_adrs+1, disassembler_.read_byte() );
			return ;
		}
		if (x == 7)
		{
			//	RST
			disassembler_.add_instruction( instr, start_adrs, start_adrs );
			return ;
		}
	}

	assert( false );
}

void DataEmitter::emit(size_t max_len)
{
	auto start_adrs = disassembler_.adrs();

	if (max_len > 8)
		max_len = 8;

	std::vector<uint8_t> data;

	for (size_t i = 0; i < max_len; i++)
	{
		data.push_back(disassembler_.read_byte());
	}

	disassembler_.add_db( start_adrs, data );
}

void DataWEmitter::emit(size_t max_len)
{
	auto start_adrs = disassembler_.adrs();

	if (max_len > 4)
		max_len = 4;

	std::vector<adrs_t> data;

	// copies max_len words from the disassembler to data
	for (size_t i = 0; i < max_len-1; i+=2)
	{
		data.push_back(disassembler_.read_word());
	}

		//	If we could not generate data, we skip the directive
	if (data.size()>0)
		disassembler_.add_dw( start_adrs, data );
}

void StrzEmitter::emit(size_t max_len)
{
	auto start_adrs = disassembler_.adrs();
	auto count = max_len;
	char buffer[32789];
	char* p = buffer;
	while (!disassembler_.finished())
	{
		uint8_t c = disassembler_.read_byte();
		*p++ = c;
		if (c == 0)
			break;
		count--;
		if (count==0)
			break;
	}

	if (count==0)
	{	//	EOS not found, we generate a DB
		std::vector<uint8_t> data;
		// copies max_len from buffer
		for (size_t i = 0; i < max_len; i++)
		{
			data.push_back(buffer[i]);
		}
		//	DB
		disassembler_.add_db( start_adrs, data );
		return ;
	}

	disassembler_.add_ds( start_adrs, buffer );
}

void StrF2Emitter::emit(size_t)
{
	adrs_t start_adrs = disassembler_.adrs();

	// std::vector<Span> res;
	char buffer[16];
	// char *p = buffer;

	// p += snprintf( p, MAX_CODE_LEN, "DB \"%c%c\"",disassembler_.read_byte(),disassembler_.read_byte());
	uint8_t c0 = disassembler_.read_byte();
	uint8_t c1 = disassembler_.read_byte();
	snprintf(buffer, 16, "%c%c", c0, c1);

	disassembler_.add_ds( start_adrs, buffer );
}

void Str8sEmitter::emit(size_t)
{
	auto start_adrs = disassembler_.adrs();
	std::vector<uint8_t> data;
	data.push_back(disassembler_.read_byte());
	disassembler_.add_db( start_adrs, data );

	start_adrs++;

	uint8_t c;

	char buf2[32768];
	char* p = buf2;
	while ((c = disassembler_.read_byte()) < 0x80)
		// p += snprintf( p, MAX_CODE_LEN, "%c", c);
		*p++ = c;

	*p = 0;

	// p += snprintf( p, MAX_CODE_LEN, "\"");
	disassembler_.unread();

	// res.push_back(Span::string(buf2));
	disassembler_.add_ds( start_adrs, buf2 );
}

Disassembler::Disassembler(const Rom &rom, const Annotations &annotations, const CPUInfo& cpuinfo)
    : rom_(rom)
    , annotations_(annotations)
	, cpu_info_(cpuinfo)
    , _emitters{
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
	return rom_.get(current_++);
}

uint16_t Disassembler::read_word()
{
	if (current_==rom_.last_adrs())
	{
		current_ ++;
		return 0xffff;
	}
	if (current_==rom_.last_adrs()+1)
	{
		return 0xffff;
	}
	uint16_t word = rom_.get_word( current_ );
	current_ += 2;
	return word;
}

void Disassembler::disassemble_one_instruction(Annotations::RegionType type, adrs_t end_adrs)
{
	auto adrs = current_;
	int size = end_adrs - adrs + 1;

	_emitters[type]->emit(size);
	adrs_t end = current_ - 1;

	if (end > end_adrs)
	{
		//	#### BUG: it is too late, we already added the falty instruction

		//	The instruction did not fit in the region
		//	We finish the disassembly with a DB
		current_ = adrs;
		disassemble_one_instruction(Annotations::kDATA, end_adrs);
		return;
	}
}

void Disassembler::disassemble_type(Annotations::RegionType type, adrs_t end_adrs)
{
	while (current_ <= end_adrs)
	{
		adrs_t start_adrs = current_;
		disassemble_one_instruction(type, end_adrs);
		if (start_adrs==current_)
		{
			//	We made no progress, we generate a DB
			disassemble_one_instruction(Annotations::kDATA, end_adrs);
		}
	}
}

void Disassembler::disassemble_label(const Label& l)
{
	adrs_t start_adrs = l.start_adrs();
	adrs_t end_adrs = l.end_adrs();

	//	Before the rom, we skip
	if (end_adrs<rom_.load_adrs())
		return;

	//	After the rom, we skip
	if (start_adrs>rom_.last_adrs())
		return;

	//	We make sure we don't go out of the rom
	if (start_adrs<rom_.load_adrs())
		start_adrs=rom_.load_adrs();

	if (end_adrs>rom_.last_adrs())
		end_adrs = rom_.last_adrs();

	current_ = start_adrs;

	if (l.comment()!="")
	{
		//	We add a blank line
		add_blank(current_);

		// split the comment into lines
		std::vector<std::string> comment_lines;
		std::string comment = l.comment();
		size_t pos = 0;
		while ((pos = comment.find("\n")) != std::string::npos)
		{
			comment_lines.push_back(comment.substr(0, pos));
			comment.erase(0, pos + 1);
		}
		if (comment.size() > 0)
			comment_lines.push_back(comment);

		for (const auto &line : comment_lines)
		{
			add_comment(line);
		}

		add_blank(current_);
	}

	add_label(l);
	disassemble_type(l.type(), end_adrs);
}

Disassembly Disassembler::disassemble()
{
	lines_.clear();

	auto line = new OrgDirectiveLine(rom_, 0, rom_.load_adrs());

	lines_.push_back(line);

	for (const auto& l : annotations_.labels())
	{
		disassemble_label(l);
	}

	return Disassembly(std::move(lines_));
}

void Disassembler::dump()
{
	std::clog << "Dumping disassembler state" << (void*)this << std::endl;
	std::clog << "Current address: " << current_ << std::endl;
	std::clog << "Data size: " << rom_.size() << std::endl;
}
