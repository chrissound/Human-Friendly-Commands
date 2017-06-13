#files
makeFilePermissionExecutable() { chmod +x $1 }
makeOwnedByMyself() { sudo chown $USER:$USER -R $1 }
makeFilePermissionEverything() { sudo chmod 777 -R $1 }

#listFiles
alias llSortBySizeAscend="ll -S -h"
alias llSortBySizeDescend="ll -S -h -r"
alias llSortByTime="ll -tr"

#
alias makeZip="zip -r $(basename $PWD) ."

#search
findByFilename() { find . -name "$1" }
findByFilenameCaseInsensitive() { find . -iname "$1" }

#docker
stopAllDockerContainers() { sudo docker stop `sudo docker ps -q`}
deleteDockerComposeVolumes() { sudo docker-compose down -v }
listRunningDockerContainers() { sudo docker ps}
listRunningDockerContainerIps() { sudo docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(sudo docker ps -q) }
enterDockerContainerBash() { sudo docker exec -it $(sudo docker ps --format "{{.Names}}" | fzf | cat) /bin/bash }


# git
cdGitProjectRoot() { cd `git rev-parse --show-toplevel` }

# arch linux pacman
pacmanInstall () { sudo pacman -S $1}
pacmanUpdate () { sudo pacman -Syu }

# systemd
alias startService="sudo systemctl start "
alias stopService="sudo systemctl stop "


# outputFiltering
alias filterExclude="grep -v"
alias filterOnly="grep"

# misc
backup () { cp -r $1 $1.backup }
