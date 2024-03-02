module directory

import os

fn test_create_delete_directory() {
	mut path := '/tmp/v/dir_test'
	create_directory(path) or { println(err) }
	assert exists(path)
	delete_directory(path) or { println(err) }
	//
	path = '/tmp/v/dir_test/'
	create_directory(path) or { println(err) }
	assert exists(path)
	delete_directory(path) or { println(err) }
}

fn test_exists() {
	assert exists('/tmp')
	assert exists('/duarte') == false
	assert exists(@FILE) == false
}

fn test_get_files() {
	path := get_parent(@FILE)
	files := get_files(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for file in files {
		if file.fullpath() == @FILE {
			cond = true
			break
		}
	}
	assert cond
}

fn test_get_all_files() {
	path := get_parent(@FILE)
	files := get_all_files(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for file in files {
		if file.fullpath() == @FILE {
			cond = true
			break
		}
	}
	assert cond
}

fn test_get_directories() {
	path := get_parent(@FILE)
	dirs := get_directories(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for dir in dirs {
		if dir.path() == path {
			cond = true
			break
		}
	}
	assert cond
}

fn test_get_all_directories() {
	path := get_parent(@FILE)
	dirs := get_all_directories(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for dir in dirs {
		if dir.name() == '.git' {
			cond = true
			break
		}
	}
	assert cond
}

fn test_get_directory_entries() {
	path := get_parent(@FILE)
	entries := get_directory_entries(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for entry in entries {
		if entry.fullpath() == @FILE {
			cond = true
			break
		}
	}
	assert cond
}

fn test_get_all_directories_entries() {
	path := get_parent(@FILE)
	entries := get_all_directory_entries(path) or {
		println(err)
		assert false
		return
	}
	//
	mut cond := false
	for entry in entries {
		if entry.fullpath() == @FILE {
			cond = true
			break
		}
	}
	assert cond
}

fn test_move_dir() {
	a := '/tmp/a'
	b := '/tmp/b'
	c := '/tmp/c'
	//
	create_directory(a) or { assert false }
	move(a, b) or { assert false }
	assert exists(a) == false
	//
	create_directory(c) or { assert false }
	//
	move(b, c) or {
		// expected
	}
	//
	delete_directory(b) or { assert false }
	delete_directory(c) or { assert false }
}

fn test_move_file() {
	a := '/tmp/a'
	b := '/tmp/b.v'
	//
	create_directory(a) or { assert false }
	os.create(b) or { assert false }
	move(a, b) or {
		// expected
	}
	move(b, a) or {
		// expected
	}
	assert exists(a)
	//
	delete_directory(a) or { assert false }
	os.rm(b) or { assert false }
}

fn test_move_dir_to_file() {
	a := '/tmp/a'
	b := @FILE
	//
	create_directory(a) or { assert false }
	move(a, b) or {
		// expected
	}
	assert exists(a)
	//
	delete_directory(a) or { assert false }
}

fn test_current_directoy() {
	cd := get_parent(@FILE)
	assert cd == get_current_directory()
	//
	tmp := $if linux {
		'/tmp'
	} $else $if macos {
		'/private/tmp'
	} $else {
		''
	}
	set_current_directory(tmp) or { assert false }
	assert tmp == get_current_directory()
}
