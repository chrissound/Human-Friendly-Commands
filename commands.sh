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

#listFiles (requires exa)
alias llSortBySizeAscend="exa -l --group-directories-first --sort=size"
alias llSortBySizeDescend="exa -l --group-directories-first --sort=size -r"
alias llSortByTime="exa -l --group-directories-first --sort=modified"

# 
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
kubectl_DescribeLastPod() { kubectl describe pod $(kubectl get pods | tail -n +2 | awk '{print $1;}') ; }
kubectl_GetPods() { kubectl get pods ; }
kubectl_GetSvc() { kubectl get svc ; }
kubectl_GetDeployments() { kubectl get deployments ; }
kubectl_GetNodes() { kubectl get nodes ; }
kubectl_EnterContainer() { kubectl exec -it $(sudo kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf) sh -c $1 }

# git
git_cdRoot() { cd "$(git rev-parse --show-toplevel)" ; }
git_ExportRepoAsZip() { git archive -o "$1" HEAD ; }
git_AddModified_Commit_Push() { git commit -am "$1" && git push ; }
git_CurrentCommitHash() { git rev-parse HEAD ; }
git_CurrentCommitHash_ToClipboard() { git_CurrentCommitHash | xclip ; }
git_Branch() { git branch -v -v; }
git_Diff() {
  git --no-pager diff --stat
  echo
  git --no-pager diff
  echo
  echo "*************************************************"
  echo "**************** GIT DIFF CACHED ****************"
  echo "*************************************************"
  echo
  git --no-pager diff --stat --cached
  echo
  git --no-pager diff --cached
}
git_Status() { git status | tac; }
git_Log() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit ; }
git_Log_NameOnly() { git log --name-only "$@" ; }
git_ResetToLatest() { git reset --hard HEAD; }
git_checkoutPaths() { git checkout -- "$@" }

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
