#include "asmgenerator.h"

#include "line.h"
#include "cpuinfo.h"

void AsmGenerator::emit_string( const std::string &str )
{
    current_line_ += str;
}

void AsmGenerator::go_to_column( size_t col )
{
    while (current_line_.size()<col)
        emit_string( " " );
}

void AsmGenerator::will_visit(const Line& line )
{
    current_line_ = "";
    emit_string( hex( line.start_adrs(), false ) );
    emit_string( ": " );
}

void AsmGenerator::did_visit(const Line& )
{
    fprintf(file_, "%s\n", current_line_.c_str() );
}


const char *AsmGenerator::hex( int n, bool symbol )
{
    static char buf[64];

    if (symbol && n>=256)
    {
        auto label = annotations_->label_from_adrs(n);
        if (label)
        {
            snprintf( buf, 64, "%s", label->name().c_str() );
            return buf;
        }
    }

    if (symbol && n>=256)
    {
        auto label = annotations_->label_before_adrs(n,5);
        if (label)
        {
            snprintf( buf, 64, "%s+%d", label->name().c_str(), n-label->start_adrs() );
            return buf;
        }
    }

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
        go_to_column( 30 );
        emit_string( "; " );
        emit_string( comment->comment_text().text() );
    }
}

void AsmGenerator::generate( const std::vector<Line *> &lines, const Annotations &annotations )
{
    annotations_ = &annotations;

    //  Create file
    file_ = fopen(filename_.c_str(), "w");

    if (!file_)
        throw std::runtime_error("Failed to open file: " + filename_);

    //  Generates all labels
    for (auto &label:annotations_->labels())
    {
        emit_string( label.name() );
        emit_string( ":" );
        // emit_string( " ; " );
        // emit_string( hex(label.start_adrs()) );
    }

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
    emit_string( "\tORG " );
    emit_string( hex(line.adrs()) );
}

void AsmGenerator::visit(const DBDirectiveLine& line)
{
    emit_string( "\tDB " );

    const char *sep = "";
    for (auto b:line.data())
    {
        emit_string( sep );
        emit_string( hex(b,true) );
        sep = ",";
    }
    end_line( line );
}

void AsmGenerator::visit(const DWDirectiveLine& line)
{
    emit_string( "\tDW " );
    const char *sep = "";
    for (auto w:line.data())
    {
        emit_string( sep );
        emit_string( hex(w,true) );
        sep = ",";
    }
    end_line( line );
}

void AsmGenerator::visit(const DSDirectiveLine& line)
{
    auto data = line.unescaped_data();

    emit_string( "\tDB " );

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
                emit_string( sep );
                emit_string( "\"" );
                emit_string( current );
                emit_string( "\"" );
                sep = ",";
                current = "";
            }
            emit_string( sep );
            emit_string( hex(c) );
            sep = ",";
        }
    }

        //  Last string
    if (current != "")
    {
        emit_string( sep );
        emit_string( "\"" );
        emit_string( current );
        emit_string( "\"" );
    }

    emit_string( ",0" );
    end_line( line );
}

void AsmGenerator::visit(const InstructionLine& line)
{
    auto inst = line.instruction();
    emit_string( "\t" );
    emit_string( inst.short_mnemonic() );

    if (inst.has_d8())
    {
        emit_string( hex(line.byte()) );
    }
    if (inst.has_d16())
    {
        emit_string( hex(line.word(),true) );
    }
    if (inst.has_adrs())
    {
        emit_string( hex(line.word(),true) );
    }
    end_line( line );
}

void AsmGenerator::visit(const LabelLine& line)
{
    emit_string( line.label().name() );
    emit_string( ":   ; " );
    emit_string( hex(line.start_adrs()) );
    end_line( line );
}

void AsmGenerator::visit(const CommentLine& line)
{
    emit_string( "; " );
    emit_string( line.comment().text() );
    end_line( line );
}

void AsmGenerator::visit(const BlankLine& line )
{
    // A blank line with no content is for formatting purposes
    // when there is content, it is for displaying the bytes in the UI
    if (line.is_empty())
        emit_string( ";" );
}
