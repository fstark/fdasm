#pragma once

#include <array>
#include <string>

#include "comment.h"

//  Describes an I/O port
class IOPort
{
public:
	IOPort() : value_(0), comments_() {}
	explicit
	IOPort( uint8_t value ) : value_(value), comments_() {}

	uint8_t value() const { return value_; }
	const std::string &name() const { return name_; }
	const std::string &full_comments() const { return full_comments_; }

	const std::vector<CommentText> &comments() const { return comments_; }

	void set_name( const std::string &name ) { name_ = name; }
	void set_comment( const std::string &comment );

protected:
    const uint8_t value_;
    std::string name_;
	std::string full_comments_;
    std::vector<CommentText> comments_;
};

//	I/O port lists
class IOList
{
	public:
		IOPort &get_port( uint8_t port ) const;

	protected:
		mutable std::array<IOPort*,256> ports_;
};

