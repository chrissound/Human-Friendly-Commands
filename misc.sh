#!/usr/bin/env bash

makeZip_CurrentDirectory() { zip -r "$(basename "$PWD" )" . ; }
makeZip_CurrentDiretory_WithoutHidden() { zip -r  "$(basename "$PWD")" . -x '.*' ; }

#search
findByFilename() { find . -name "$1" ; }
findByFilenameCaseInsensitive() { find . -iname "$1" ; }

#docker (requires docker, docker-compose)
docker_stopAllContainers() { sudo docker stop $(sudo docker ps -q); }
docker_deleteComposeVolumes() { sudo docker-compose down -v ; }
docker_showLatestCreatedContainer() { sudo docker ps -a --latest; }
docker_getLatestCreatedContainerId() { sudo docker ps -a --latest -q; }
docker_startLatestCreatedContainer() { sudo docker start "$(sudo docker ps -a --latest -q)" ;}

docker_listContainers() { sudo docker ps -a ; }
docker_listRunningContainers() { sudo docker ps; }
docker_listRunningContainerIps() { sudo docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(sudo docker ps -q) ; }
docker_enterContainerBash() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/bash ; }
docker_enterContainerSh() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/sh ; }
docker_runCommandInContainer() { sudo docker exec -it "$@"; }
docker_runCommandInContainerWithContainerPrompt() { sudo docker exec -it "$(docker_promptForRunningContainer)" "$@"; }
docker_promptForRunningContainer() { echo $(sudo docker ps --format "{{.Names}}" | fzf) ; }

docker_dockerComposeUp() { sudo docker-compose up ; }
docker_dockerComposeStop() { sudo docker-compose stop ; }

#kubernetes
kubectl_DescribeLastPod() { kubectl describe pod "$(kubectl get pods | tail -n +2 | awk '{print $1;}')" ; }
kubectl_GetPods() { kubectl get pods ; }
kubectl_GetSvc() { kubectl get svc ; }
kubectl_GetDeployments() { kubectl get deployments ; }
kubectl_GetNodes() { kubectl get nodes ; }
kubectl_EnterContainer() { kubectl exec -it "$(sudo kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" sh -c "$1" ; }

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
restoreBackup () { cp -r "$1".backup "$1" ; }
copyPathToClipboard () { readlink --no-newline -f "$1" | xclip ; }
# misc (requires xclip)
copyFileToClipboard () { cat "$1" | xclip ; }
sshSocksProxy() { ssh -D 8118 -f -C -q -N "$@" ; }
newEditFile() { touch "$1" && $EDITOR "$1" ; }
newEditExecutableFile() { touch "$1" && makeFilePermissionExecutable "$1"  && $EDITOR "$1" ; }
