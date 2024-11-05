#pragma once

#include <string>

void escape_char( char *&p, int c );
char unescape_char( const char *&p );
std::string escape( const std::string &str );
std::string unescape( const std::string &str );
