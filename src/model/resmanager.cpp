#include "resmanager.h"

#include <iostream>
#include <fstream>

ResourceManager &ResourceManager::default_manager()
{
	static ResourceManager sManager;
	return sManager;
}

void ResourceManager::register_path( const std::string &path )
{
	ResourceManager::default_manager().add_path(path);
}

const std::string ResourceManager::path_for_resource( const std::string &name ) const
{
	for (const auto &path : paths_)
	{
		std::string full_path = path + "/" + name;
		if (std::ifstream(full_path))
			return full_path;
	}

	for (const auto &path : paths_)
	{
		std::cerr << "tried [" << path + "] => [" + path + "/" + name << "]" << std::endl;
	}

	throw std::runtime_error("Resource not found: " + name);	
}

ResourceManager::ResourceManager() : paths_()
{
	add_path(".");
	if (::getenv("FDASM_RES"))
		add_path(::getenv("FDASM_RES"));
}

void ResourceManager::add_path( const std::string &path )
{
	paths_.push_back(path);
}
