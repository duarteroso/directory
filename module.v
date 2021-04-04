module directory

import v.vmod

fn init() {
}

pub fn manifest() ?vmod.Manifest {
	return vmod.decode(@VMOD_FILE)
}
