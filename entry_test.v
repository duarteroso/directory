module vidirectory

fn test_entry() {
	entry := create_entry(@FILE) or {
		assert false
		return
	}
	//
	assert entry.extension() == 'v'
	assert entry.is_file()
	assert entry.is_directory() == false
}