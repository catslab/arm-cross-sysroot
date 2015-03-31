#!/bin/bash

GV_url="http://libssh2.org/download/libssh2-1.4.2.tar.gz"
GV_sha1="7fc084254dabe14a9bc90fa3d569faa7ee943e19"

GV_depend=(
	"openssl"
	"libgpg-error"
	"libgcrypt"
)

FU_tools_get_names_from_url
FU_tools_installed "libssh2.pc"

if [ $? == 1 ]; then
	
	FU_tools_check_depend	
	
	export LIBS="${LIBS} -lpthread -ldl -lssl -lcrypto -lgpg-error -lgcrypt"

	GV_args=(
		"--host=${GV_host}"
		"--program-prefix=${UV_target}-"
		"--libdir=${UV_sysroot_dir}/lib"
		"--includedir=${UV_sysroot_dir}/include"
		"--enable-shared"
		"--disable-static"
		"--enable-debug"
		"--disable-largefile"
		"--disable-examples-build"
	)
	
	FU_file_get_download
	FU_file_extract_tar
		
	FU_build_configure	
	FU_build_make
	FU_build_install "install-strip"
	
	unset LIBS
fi