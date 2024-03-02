module directory

import os

// Entry represents an entry in a file system
pub struct Entry {
mut:
	name string
	path string
}

fn create_entry(fullpath string) !Entry {
	index := fullpath.index_last('/') or { return error('failed to create entry ${fullpath}') }
	//
	return Entry{
		name: fullpath.substr(index + 1, fullpath.len)
		path: fullpath.substr(0, index)
	}
}

// name of Entry
pub fn (e &Entry) name() string {
	return e.name
}

// path of Entry
pub fn (e &Entry) path() string {
	return e.path
}

// fullpath of Entry
pub fn (e &Entry) fullpath() string {
	return '${e.path}/${e.name}'
}

// is_file returns true if entry is a file
pub fn (e &Entry) is_file() bool {
	return os.is_file(e.fullpath())
}

// is_directory returns true if entry is a directory
pub fn (e &Entry) is_directory() bool {
	return os.is_dir(e.fullpath())
}

// extension of entry, empty if a directory or unknown
pub fn (e &Entry) extension() string {
	index := e.name.index_last('.') or { return 'none' }
	//
	return e.name.substr(index + 1, e.name.len)
}

// str format Entry to string
pub fn (e &Entry) str() string {
	return e.fullpath()
}
