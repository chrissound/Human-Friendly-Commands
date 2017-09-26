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

#listFiles
alias llSortBySizeAscend="ll -S -h"
alias llSortBySizeDescend="ll -S -h -r"
alias llSortByTime="ll -tr"

# 
makeZip() { zip -r "$(basename "$PWD" )" . ; }
makeZipWithoutHiddenPaths() { zip -r  "$(basename "$PWD")" . -x '.*' ; }

#search
findByFilename() { find . -name "$1" ; }
findByFilenameCaseInsensitive() { find . -iname "$1" ; }

#docker (requires docker, docker-compose)
stopAllDockerContainers() { sudo docker stop $(sudo docker ps -q); }
deleteDockerComposeVolumes() { sudo docker-compose down -v ; }
showLatestCreatedDockerContainer() { sudo docker ps -a --latest; }
getLatestCreatedDockerContainerId() { sudo docker ps -a --latest -q; }
startLatestCreatedDockerContainer() { sudo docker start "$(sudo docker ps -a --latest -q)" ;}
listDockerContainers() { sudo docker ps -a ; }
listRunningDockerContainers() { sudo docker ps; }
listRunningDockerContainerIps() { sudo docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(sudo docker ps -q) ; }
enterDockerContainerBash() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/bash ; }
enterDockerContainerSh() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/sh ; }
runCommandInDockerContainer() { sudo docker exec -it "$@"; }
runCommandInDockerContainerWithContainerPrompt() { sudo docker exec -it "$(promptForRunningDockerContainer)" "$@"; }
promptForRunningDockerContainer() { echo $(sudo docker ps --format "{{.Names}}" | fzf) ; }
dockerComposeUp() { sudo docker-compose up ; }
dockerComposeStop() { sudo docker-compose stop ; }

#kubernetes
kubectlDescribeLastPod() { kubectl describe pod $(kubectl get pods | tail -n +2 | awk '{print $1;}') ; }
kubectlGetPods() { kubectl get pods ; }
kubectlGetSvc() { kubectl get svc ; }
kubectlGetDeployments() { kubectl get deployments ; }
kubectlGetNodes() { kubectl get nodes ; }

# git
cdGitProjectRoot() { cd "$(git rev-parse --show-toplevel)" ; }
gitExportRepoAsZip() { git archive -o "$1" HEAD ; }
git_AddModified_Commit_Push() { git commit -am "$1" && git push ; }
git_CurrentCommitHash() { git rev-parse HEAD ; }
git_CurrentCommitHash_ToClipboard() { git_GetCurrentCommit | xclip ; }
git_Branch() { git branch ; }
git_Diff() { git diff && echo "********* GIT CACHED:*******" && git diff --cached ; }
git_Status() { git status | tac; }
git_Log() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit | tac; }
git_Log_NameOnly() { git log --name-only "$@" ; }

# arch linux pacman
pacmanInstall () { sudo pacman -S "$1"; }
pacmanUpdate () { sudo pacman -Syu ; }

# systemd
alias startService="sudo systemctl start "
alias stopService="sudo systemctl stop "


# outputFiltering
alias filterExclude="rg -v"
alias filterOnly="rg"

# misc
backup () { cp -r "$1" "$1".backup ; }
restoreBackup () { cp -r "$1".backup "$1" ; }
copyPathToClipboard () { readlink -f "$1" | xclip ; }
# misc (requires xclip)
copyFileToClipboard () { cat "$1" | xclip ; }
sshSocksProxy() { ssh -D 8118 -f -C -q -N "$@" ; }
newEditFile() { touch "$1" && $EDITOR "$1" ; }
newEditExecutableFile() { touch "$1" && makeFilePermissionExecutable "$1"  && $EDITOR "$1" ; }
