#files
makeFilePermissionExecutable() { chmod +x $1 }
makeOwnedByMyself() { sudo chown $USER:$USER -R $1 }
makeFilePermissionEverything() { sudo chmod 777 -R $1 }

#search
findByFilename() { find . -name "$1" }
findByFilenameCaseInsensitive() { find . -iname "$1" }

#docker
stopAllDockerContainers() { sudo docker stop `sudo docker ps -q`}
deleteDockerComposeVolumes() { sudo docker-compose down -v }
listRunningDockerContainers() { sudo docker ps}


# git
cdGitProjectRoot() { cd `git rev-parse --show-toplevel` }

# arch linux pacman
pacmanInstall () { sudo pacman -S $1}
pacmanUpdate () { sudo pacman -Syu }

# outputFiltering
alias filterExclude="grep -v"
alias filterOnly="grep"
