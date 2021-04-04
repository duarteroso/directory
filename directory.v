module vidirectory

import os

// create the complete hierarchy of path
pub fn create(path string) ? {
	os.mkdir_all(path) or { return error('failed to create directory $path') }
}

// delete recursively the content of path
pub fn delete(path string) ? {
	os.rmdir_all(path) or { return error('failed to delete directory $path') }
}

// exists return true if a path exists
pub fn exists(path string) bool {
	return os.is_dir(path)
}

pub fn get_directories(path string) ?[]Entry {
	list := os.ls(path) or { return error('failed to list: $path') }
	//
	mut dirs := []Entry{}
	for elt in list {
		if os.is_dir(elt) {
			dirs << Entry {
				name: elt
				path: path
			}
		}
	}
	//
	return dirs
}

// get_files returns all files under path, excluding directories
pub fn get_files(path string) ?[]Entry {
	list := os.ls(path) or { return error('failed to list: $path') }
	//
	mut files := []Entry{}
	for elt in list {
		if os.is_file(elt) {
			files << Entry{
				name: elt
				path: path
			}
		}
	}
	//
	return files
}

// get_directory_entries returns all entries under path
pub fn get_directory_entries(path string) ?[]Entry {
	list := os.ls(path) or { return error('failed to list: $path') }
	//
	mut entries := []Entry{}
	for elt in list {
		entries << Entry{
			name: elt
			path: path
		}
	}
	//
	return entries
}

// get_all_directories recursively returns all directories under path, excluding files
pub fn get_all_directories(path string) ?[]Entry {
	mut dirs := []Entry{}
	entries := get_directory_entries(path) ?
	//
	for entry in entries {
		if entry.is_directory() {
			dirs << entry
			dirs << get_all_directories(entry.fullpath()) ?
		}
	}
	//
	return dirs
}

// get_all_files recursively returns all files under path, excluding directories
pub fn get_all_files(path string) ?[]Entry {
	mut files := []Entry{}
	entries := get_directory_entries(path) ?
	//
	for entry in entries {
		if entry.is_file() {
			files << entry
		} else if entry.is_directory() {
			files << get_all_files(entry.fullpath()) ?
		} 
	}
	//
	return files
}

// get_all_directory_entries recursively returns all entries under path
pub fn get_all_directory_entries(path string) ?[]Entry {
	list := get_directory_entries(path) ?
	//
	mut entries := []Entry{}
	for elt in list {
		entries << elt
		if elt.is_directory() {
			entries << get_all_directory_entries(elt.fullpath()) ?
		}
	}
	//
	return entries
}

// get_parent returns the path without the last entry
pub fn get_parent(path string) string {
	return os.dir(path)
}

// move directory from source to destination
pub fn move(source string, destination string) ? {
	if os.is_file(source) {
		return error('$source is not a directory')
	}
	//
	if exists(destination) {
		return error('$destination already exists')
	}
	if os.is_file(destination) {
		return error('$destination is not a directory')
	}
	//
	os.mv(source, destination) or { return error('failed to move from $source to $destination') }
}

// set_current_directory changes the current directory
pub fn set_current_directory(path string) ? {
	if os.is_file(path) {
		return error('$path is not a directory')
	}
	if exists(path) == false {
		return error('$path does not exist')
	}
	//
	os.chdir(path)
}

// get_current_directory returns the current directory
pub fn get_current_directory() string {
	return os.getwd()
}
