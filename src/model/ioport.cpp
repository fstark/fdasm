#include "ioport.h"

#include <iostream>

const std::string IOPort::short_comment() const
{
    //  We return the first line of the comment
    auto chunks = comment_.chunks();
    
    if (chunks.size()==0)
        return "";

    std::cout << "> " << chunks[0] << "\n";

    return chunks[0];
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
