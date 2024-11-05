#pragma once

#include "annotations.h"
#include "common.h"
#include <vector>

class Label
{
public:
	Label(adrs_t start_adrs, const std::string& name, Annotations::RegionType type, const std::string& comment = "")
	    : start_adrs_{ start_adrs }
	    , end_adrs_{ start_adrs }
	    , name_{ name }
	    , type_{ type }
		, comment_{ comment }
	{
	}

	adrs_t adrs() const { return start_adrs_; }
	adrs_t start_adrs() const { return start_adrs_; }
	adrs_t end_adrs() const { return end_adrs_; }
	Annotations::RegionType type() const { return type_; }
	const std::string& comment() const { return comment_; }
	void set_type(Annotations::RegionType type) { type_ = type; }
	void set_comment(const std::string& comment) { comment_ = comment; }

	const std::string& name() const { return name_; }

	friend class Annotations;

private:
	adrs_t start_adrs_;
	adrs_t end_adrs_; //  Automatically set by Annotations::labels_changed()
	std::string name_;
	Annotations::RegionType type_;
	std::string comment_;

	void set_end_adrs(adrs_t end_adrs) { end_adrs_ = end_adrs; }

};
