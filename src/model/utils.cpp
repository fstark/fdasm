#include "utils.h"

void escape_char( char *&p, int c )
{
	if (c == 0x0a)
	{
		*p++ = '\\';
		*p++ = 'n';
	}
	else if (c == 0x0d)
	{
		*p++ = '\\';
		*p++ = 'r';
	}
	else if (c == 0x09)
	{
		*p++ = '\\';
		*p++ = 't';
	}
	else if (c == 0x22)
	{
		*p++ = '\\';
		*p++ = '"';
	}
	else if (c == 0x5c)
	{
		*p++ = '\\';
		*p++ = '\\';
	}
	else if (c < 0x20 || c > 0x7f)
	{
		*p++ = '\\';
		*p++ = 'x';
		*p++ = "0123456789ABCDEF"[c >> 4];
		*p++ = "0123456789ABCDEF"[c & 0x0f];
	}
	else
	{
		*p++ = c;
	}
}

char unescape_char( const char *&p )
{
	if (*p == '\\')
	{
		p++;
		if (*p == 'n')
		{
			p++;
			return 0x0a;
		}
		if (*p == 'r')
		{
			p++;
			return 0x0d;
		}
		if (*p == 't')
		{
			p++;
			return 0x09;
		}
		if (*p == '"')
		{
			p++;
			return 0x22;
		}
		if (*p == '\\')
		{
			p++;
			return 0x5c;
		}
		if (*p == 'x')
		{
			p++;
			int c = 0;
			for (int i = 0; i < 2; i++)
			{
				if (*p >= '0' && *p <= '9')
					c = c * 16 + *p - '0';
				else if (*p >= 'A' && *p <= 'F')
					c = c * 16 + *p - 'A' + 10;
				else if (*p >= 'a' && *p <= 'f')
					c = c * 16 + *p - 'a' + 10;
				else
					break;
				p++;
			}
			return c;
		}
	}
	return *p++;
}

std::string escape( const std::string &str )
{
	char buffer[32768];
	char *p = buffer;
	for (char c : str)
		escape_char( p, c );
	*p = 0;
	return buffer;
}

std::string unescape( const std::string &str )
{
	char buffer[32768];
	char *p = buffer;
    const char *q = str.c_str();
	while (*q)
		*p++ = unescape_char( q );
	*p = 0;
	return buffer;
}
