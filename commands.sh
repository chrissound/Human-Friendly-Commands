makeFilePermissionExecutable() { chmod +x $1 }

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
