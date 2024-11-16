#pragma once

#include <array>
#include <string>

#include "comment.h"

//  Describes an I/O port
class IOPort
{
public:
	IOPort() : value_(0), comment_("") {}
	explicit
	IOPort( uint8_t value ) : value_(value), comment_("") {}

	uint8_t value() const { return value_; }
	const std::string &name() const { return name_; }
	const std::string &comment() const { return comment_.text(); }
	const std::string short_comment() const;

	void set_name( const std::string &name ) { name_ = name; }
	void set_comment( const std::string &comment ) { comment_ = comment; }

protected:
    const uint8_t value_;
    std::string name_;
    CommentText comment_;
};

//	I/O port lists
class IOList
{
	public:
		IOPort &get_port( uint8_t port ) const;

	protected:
		mutable std::array<IOPort*,256> ports_;
};

