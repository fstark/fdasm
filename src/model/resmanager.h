#pragma once

#include <string>
#include <vector>

//	Handles access to the resources of the application
class ResourceManager
{
public:
	//	The default resource manager
	static ResourceManager &default_manager();

	//	Add path to the default resource manager
	static void register_path( const std::string &path );

	//	Look for a resource. Throws an exception if not found
	const std::string path_for_resource( const std::string &name ) const;

protected:
	ResourceManager();
	void add_path( const std::string &path );

	std::vector<std::string> paths_;
};
