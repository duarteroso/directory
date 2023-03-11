module directory

import os

pub fn delete_file(path string) ! {
	if os.is_file(path) == false {
		return
	}
	os.rm(path) or { return error('failed to delete file ${path}') }
}
