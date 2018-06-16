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
delete_EmptyFiles_Recursively() { find . -type f -empty -delete ; }
delete_Recursive() { rm -rf "$1" ; }
delete_EverythingInCurrentDir() { find . -delete; }
get_firstFileWithExtension() { find -iname "*.$1" | head -n 1 ; }

# directories
delete_EmptyDirectories_Recursively() { find . -type d -empty -delete ; }
file_getOctalPermission() { stat -c "%a %n" "$@" ; }

createFile() {
  for p do
    _dir="$(dirname -- "$p")"
    mkdir -p -- "$_dir" && touch -- "$p"
  done
}
