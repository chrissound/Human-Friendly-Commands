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
alias makeZipWithoutHiddenPaths="zip -r  $(basename $PWD) . -x '.*'"

#search
findByFilename() { find . -name "$1" }
findByFilenameCaseInsensitive() { find . -iname "$1" }

#docker (requires docker, docker-compose)
stopAllDockerContainers() { sudo docker stop `sudo docker ps -q`}
deleteDockerComposeVolumes() { sudo docker-compose down -v }
showLatestCreatedDockerContainer() { sudo docker ps -a --latest}
getLatestCreatedDockerContainerId() { sudo docker ps -a --latest -q}
startLatestCreatedDockerContainer() { sudo docker start `sudo docker ps -a --latest -q`}
listDockerContainers() { sudo docker ps -a }
listRunningDockerContainers() { sudo docker ps}
listRunningDockerContainerIps() { sudo docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(sudo docker ps -q) }
enterDockerContainerBash() { sudo docker exec -it $(sudo docker ps --format "{{.Names}}" | fzf | cat) /bin/bash }
runCommandInDockerContainer() { sudo docker exec -it "$@"}
runCommandInDockerContainerWithContainerPrompt() { sudo docker exec -it $(promptForRunningDockerContainer) "$@"}
promptForRunningDockerContainer() { echo $(sudo docker ps --format "{{.Names}}" | fzf) }


# git
cdGitProjectRoot() { cd `git rev-parse --show-toplevel` }
gitExportRepoAsZip() { git archive -o "$1" HEAD }

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
backup () { cp -r $1 $1.backup ; }
copyPathToClipboard () { readlink -f $1 | xclip ; }
# misc (requires xclip)
copyFileToClipboard () { cat $1 | xclip ; }
