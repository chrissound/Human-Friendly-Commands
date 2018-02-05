#!/usr/bin/env bash

#files
makeFilePermissionExecutable() { chmod +x "$@" ; }
makeOwnedByMyself() { sudo chown "$USER":"$USER" -R "$@" ; }
makeFilePermissionEverything() { sudo chmod 777 -R "$@" ; }
getLastModifiedFileInDirectory() { ls -t "$1" | head -n1 ; }
get_AbsolutePath_LastModifiedFileInDirectory() {
  # remove trailing slash
	dir=${1%/}
  lmf=$(getLastModifiedFileInDirectory "$1")
	echo "$dir/$lmf"
}
deleteEmptyFiles_Recursively() { find . -type f -empty -delete ; }
deleteRecursive() { rm -rf "$1" ; }

# directories
deleteEmptyDirectories_Recursively() { find . -type d -empty -delete ; }
file_getOctalPermission() { stat -c "%a %n" "$@" ; }
