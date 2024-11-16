#include "asmgenerator.h"

#include "line.h"
#include "cpuinfo.h"

const char *hex( int n )
{
    static char buf[64];

    if (n<10)
        snprintf( buf, 64, "%d", n );
    else if (n<16)
        snprintf( buf, 64, "0%XH", n );
    else if (n<0xa0)
        snprintf( buf, 64, "%02XH", n );
    else if (n<0x100)
        snprintf( buf, 64, "0%02XH", n );
    else if (n<0xA00)
        snprintf( buf, 64, "%03XH", n );
    else if (n<0x1000)
        snprintf( buf, 64, "0%04XH", n );
    else if (n<0xA000)
        snprintf( buf, 64, "%04XH", n );
    else
        snprintf( buf, 64, "0%04XH", n );

    return buf;
}

void AsmGenerator::end_line( const Line &line )
{
    auto adrs = line.start_adrs();
	const Comment *comment = annotations_->comment_from_adrs( adrs );
    if (!line.is_empty() && comment)
    {
        fprintf(file_, "\t; %s\n", comment->comment_text().text().c_str() );
    }
    else
    {
        fprintf(file_, "\n" );
    }
}

void AsmGenerator::generate( const std::vector<Line *> &lines, const Annotations &annotations )
{
    annotations_ = &annotations;

    //  Create file
    file_ = fopen(filename_.c_str(), "w");

    if (!file_)
        throw std::runtime_error("Failed to open file: " + filename_);

    for (auto &line: lines)
    {
        line->visit(*this);
    }

    fprintf( file_, "\tEND\n" );

    //  Close file
    fclose(file_);
}

void AsmGenerator::visit(const OrgDirectiveLine& line)
{
    fprintf(file_, "\tORG %s", hex(line.adrs()) );
    fprintf( file_, "\n" );
}

void AsmGenerator::visit(const DBDirectiveLine& line)
{
    fprintf(file_, "\tDB " );
    const char *sep = "";
    for (auto b:line.data())
    {
        fprintf( file_, "%s%s", sep, hex(b) );
        sep = ",";
    }
    end_line( line );
}

void AsmGenerator::visit(const DWDirectiveLine& line)
{
    fprintf(file_, "\tDW " );
    const char *sep = "";
    for (auto w:line.data())
    {
        fprintf( file_, "%s%s", sep, hex(w) );
        sep = ",";
    }
    end_line( line );
}

void AsmGenerator::visit(const DSDirectiveLine& line)
{
    auto data = line.unescaped_data();

    fprintf(file_, "\tDB ");

    std::string current = "";
    const char *sep = "";
    for (auto c : data)
    {
        if (isprint(c))
        {
            current += c;
        }
        else
        {
            if (current != "")
            {
                fprintf(file_, "%s\"%s\"", sep, current.c_str() );
                sep = ",";
                current = "";
            }
            fprintf(file_, "%s%s", sep, hex(c) );
            sep = ",";
        }
    }

        //  Last string
    if (current != "")
    {
        fprintf(file_, "%s\"%s\"", sep, current.c_str() );
    }

    fprintf(file_, ",0" );
    end_line( line );
}

void AsmGenerator::visit(const InstructionLine& line)
{
    auto inst = line.instruction();
    fprintf(file_, "\t%s", inst.short_mnemonic().c_str() );
    if (inst.has_d8())
    {
        fprintf(file_, "%s", hex(line.byte()));
    }
    if (inst.has_d16())
    {
        fprintf(file_, "%s", hex(line.word()));
    }
    if (inst.has_adrs())
    {
        fprintf(file_, "%s", hex(line.word()));
    }
    end_line( line );
}

void AsmGenerator::visit(const LabelLine& line)
{
    fprintf(file_, "%s:", line.label().name().c_str() );
    end_line( line );
}

void AsmGenerator::visit(const CommentLine& line)
{
    fprintf(file_, "; %s", line.comment().text().c_str() );
    end_line( line );
}

void AsmGenerator::visit(const BlankLine& line )
{
    // A blank line with no content is for formatting purposes
    // when there is content, it is for displaying the bytes in the UI
    if (line.is_empty())
        fprintf(file_, ";\n" );
}
