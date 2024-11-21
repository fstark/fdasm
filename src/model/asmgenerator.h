#pragma once

#include <string>
#include <vector>

#include "line.h"

#include <stdio.h>

//  Generates an assembly file from a list of lines
class AsmGenerator : protected DefaultLineVisitor
{
public:
    AsmGenerator(const std::string& filename)
        : filename_{ filename } {}

    void generate( const std::vector<Line *> &lines, const Annotations &annotations );

    protected:

        std::string current_line_;
        void emit_string( const std::string &str );
        void go_to_column( size_t col );

        const char *hex( int n, bool symbol = false );

        void visit(const OrgDirectiveLine& line);
        void visit(const DBDirectiveLine& line);
        void visit(const DWDirectiveLine& line);
        void visit(const DSDirectiveLine& line);
        void visit(const InstructionLine& line);
        void visit(const LabelLine& line);
        void visit(const CommentLine& line);
        void visit(const BlankLine& line);

        void will_visit(const Line& line);
        void did_visit(const Line& line);

        void end_line( const Line &line );

        std::string filename_;
        FILE *file_;
        const Annotations *annotations_;
};
