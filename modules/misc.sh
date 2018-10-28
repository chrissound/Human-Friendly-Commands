#!/usr/bin/env bash

makeZip_CurrentDirectory() { zip -r "$(basename "$PWD" )" . ; }
makeZip_CurrentDiretory_WithoutHidden() { zip -r  "$(basename "$PWD")" . -x '.*' ; }

#search
findByFilename() { find . -name "$1" ; }
findByFilenameCaseInsensitive() { find . -iname "$1" ; }
isTextPresentInFilodir() { grep -q "$1" "$2" ; }

# git

# arch linux pacman
pacmanInstall () { sudo pacman -S "$1"; }
pacmanUpdate () { sudo pacman -Syu ; }

# systemd
alias startService="sudo systemctl start "
alias stopService="sudo systemctl stop "

# outputFiltering
alias filterExclude="rg -v"
alias filterOnly="rg"
alias filterExcludeEmptyLines="grep -v -e '^$'"

# misc
backup () { cp -r "$1" "$1".backup ; }
backup_appendWithDate () { cp -r "$1" "$1"."$(date_ddmmyyyy)".backup ; }
backup_appendWithTimeDate () { cp -r "$1" "$1"."$(date_hhmmssddmmyyyy)".backup ; }
restoreBackup () { cp -r "$1".backup "$1" ; }
clipboard_copyPath () { readlink --no-newline -f "$1" | xclip -selection clipboard ; }
clipboard_copyCurrentPath () { clipboard_copyPath "$(pwd)"; }
# misc (requires xclip)
clipboard_copyFileContents () { xclip < "$1"; }
sshSocksProxy() { ssh -D 8118 -f -C -q -N "$@" ; }
newEditFile() { touch "$1" && $EDITOR "$1" ; }
newEditExecutableFile() { touch "$1" && makeFilePermissionExecutable "$1"  && $EDITOR "$1" ; }

date_ddmmyyyy () { date '+%d-%m-%Y' ;}
date_hhmmssddmmyyyy () { date '+%H-%M-%S-%d-%m-%Y' ;}

wget_toStdOut() { wget -qO- "$@" ;}
wget_ignoreSslCert()  { wget  --no-check-certificate "$@" ;}

# file manipulation
file_delete_line() { sed -i "${2}d" "$1" ;}

print_everyPathLevel_ofPath() { 
  print "$1"

  if [ "$1" != "/" ]
  then
    print_everyPathLevel_ofPath "$(dirname "$1")"
  fi
  }
