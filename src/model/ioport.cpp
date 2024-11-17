#include "ioport.h"

#include <iostream>

void IOPort::set_comment( const std::string &comment )
{
    full_comments_ = comment;

    //  We create a comment text for each line in comment
    comments_.clear();
    size_t pos = 0;
    while (pos<comment.size())
    {
        size_t eol = comment.find("\n", pos);
        if (eol==std::string::npos)
        {
            comments_.emplace_back( comment.substr(pos) );
            break;
        }
        comments_.emplace_back( comment.substr(pos, eol-pos) );
        pos = eol+1;
    }
}

IOPort &IOList::get_port( uint8_t port ) const
{
    auto p = ports_[port];
    if (!p)
    {
        p = new IOPort(port);
        ports_[port] = p;
    }
    return *p;
}
