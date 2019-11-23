#!/usr/bin/env bash

# Dependencies: exa

#listFiles
alias listDirectoryContentsSortByAlphabeticallyAscend="exa -l --group-directories-first"
alias listDirectoryContentsSortBySizeAscend="exa -l --group-directories-first --sort=size"
alias listDirectoryContentsSortBySizeDescend="exa -l --group-directories-first --sort=size -r"
alias listDirectoryContentsSortByTimeAscend="exa -l --group-directories-first --sort=modified"
alias listDirectoryContentsSortByTimeDescend="exa -l --group-directories-first --sort=modified -r"

#!/usr/bin/env bash

#files
makeFilePermissionExecutable() { chmod +x "$@" ; }
makeAllShFilesPermissionExecutable() { chmod +x ./*.sh ; }
makeOwnedByMyself() { sudo chown "$USER":"$(id -g "$USER")" -R "$@" ; }
makeFilePermissionEverything() { sudo chmod 777 -R "$@" ; }
# shellcheck disable=SC2012
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
# get_firstFileWithExtension() { find -iname "*.$1" . | head -n 1 ; }

# directories
delete_EmptyDirectories_Recursively() { find . -type d -empty -delete ; }
file_getOctalPermission() { stat -c "%a %n" "$@" ; }

createFile() {
  for p do
    _dir="$(dirname -- "$p")"
    mkdir -p -- "$_dir" && touch -- "$p"
  done
}

vimLastDownloadedFile() { vim ~/Downloads/"$(getLastModifiedFileInDirectory ~/Downloads)" ; }
#!/usr/bin/env bash

git_cdRoot() { cd "$(git rev-parse --show-toplevel)" ; }
git_ExportRepoAsZip() { git archive -o "$1" HEAD ; }
git_AddModified_Commit_Push() { git commit -am "$1" && git push ; }
git_CurrentCommitHash() { git rev-parse HEAD ; }
git_CurrentCommitHash_ToClipboard() { git_CurrentCommitHash | xclip ; }
git_Branch() { git branch -v -v; }
git_Diff() {
  git --no-pager diff --stat
  echo
  git --no-pager diff --color | diff-so-fancy

  if ! git diff-index --cached --quiet HEAD --; then
    echo
    echo "*************************************************"
    echo "**************** GIT DIFF CACHED ****************"
    echo "*************************************************"
    echo
    git --no-pager diff --stat --cached
    echo
    git --no-pager diff --cached --color | diff-so-fancy
  fi

}
git_Status() { git status | tac; }
git_Log() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit ; }
git_Log_NameOnly() { git log --name-only "$@" ; }
git_ResetToLatest() { git reset --hard HEAD ; }
git_checkoutPaths() { git checkout -- "$@" ; }
git_FirstCommitHash() { git rev-list --max-parents=0 HEAD ; }
#!/usr/bin/env bash

# compression

makeZip_CurrentDirectory() { zip -r "$(basename "$PWD" )" . ; }
makeZip_CurrentDiretory_WithoutHidden() { zip -r  "$(basename "$PWD")" . -x '.*' ; }

makeGZip_CurrentDirectory() { tar -c --use-compress-program=pigz -f "$(basename "$PWD")".tar.gz . ; }

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
backup () { cp -a "$1" "$1".backup ; }
backup_appendWithDate () { cp -a "$1" "$1"."$(date_ddmmyyyy)".backup ; }
backup_appendWithTimeDate () { cp -a "$1" "$1"."$(date_hhmmssddmmyyyy)".backup ; }
restoreBackup () { cp -a "$1".backup "$1" ; }
clipboard_copyPath () { readlink --no-newline -f "$1" | xclip -selection clipboard ; }
clipboard_copyCurrentPath () { clipboard_copyPath "$(pwd)"; }
# misc (requires xclip)
clipboard_copyFileContents () { xclip < "$1"; }
sshSocksProxy() { ssh -D 8118 -f -C -q -N "$@" ; }
newEditFile() { touch "$1" && $EDITOR "$1" ; }
newEditExecutableFile() { touch "$1" && makeFilePermissionExecutable "$1"  && $EDITOR "$1" ; }
clipboard_copySshPublicKey() { xclip < ~/.ssh/id_rsa.pub ; }

date_ddmmyyyy () { date '+%d-%m-%Y' ;}
date_hhmmssddmmyyyy () { date '+%H-%M-%S-%d-%m-%Y' ;}

wget_toStdOut() { wget -qO- "$@" ;}
wget_ignoreSslCert()  { wget  --no-check-certificate "$@" ;}

# file manipulation
file_delete_line() { sed -i "${2}d" "$1" ;}

print_everyPathLevel_ofPath() {

  if [[ "$#" = 0 ]]; then
      print_everyPathLevel_ofPath "$PWD"
  else
      if [ "$1" != "/" ];
      then
          print_everyPathLevel_ofPath "$(dirname "$1")"
      fi
  fi

}

text_sanitize_filesystem_name () { echo "$1" | sed -e "s/ /-/g" | tr -cd '[:alnum:]_-' ; }
#!/usr/bin/env bash

git_initAndCommitInitial() { git init; git add .; git commit -m "inital" ;}
git_DiffPager() { git_Diff | less ;}
git_searchCommitMessagesInAllBranches() { git log --all --grep="$1" ;}
git_forceClone() {

  if [[ "$#" = 1 ]]; then
    set -x
    git init
    git remote add origin "$1"
    git fetch
    git checkout -f -t origin/master  
    git checkout . 
  elif [[ "$#" = 2 ]]; then
    echo "Hmmmmmmm"
    set -x
    git init
    git remote add origin "$1"
    git fetch
    git checkout -f -t origin/"$2"
    git checkout . 
  else
    echo "Not enough parameters" 1>&2
    exit 1
  fi
}
#!/usr/bin/env bash

# Create a repo named by the current directory
# Accepts 1 STRING parameter for the repo description
# Depends on bin: jq
# Depends on env: GITHUB_USER, GITHUB_API_TOKEN
github_createRepo() {
  (
    set -e
    projName="$(basename "$PWD")"
    json=$(jq -n \
        --arg name "$projName" \
        --arg description "$1" \
        '{"name":$name, "description":$description}')

    curl -u "$GITHUB_USER":"$GITHUB_API_TOKEN" https://api.github.com/user/repos -d "$json"
    if [ -d .git ]; then
        git remote add origin git@github.com:"$GITHUB_USER"/"$projName".git
        git push origin master
    else
        git init
        git remote add origin git@github.com:"$GITHUB_USER"/"$projName".git
        git push origin master
    fi;
  )
};

#!/usr/bin/env bash

# hpack (requires misc.sh, jq, yaml, sponge, hpack)
hpack_AddDependencyNaively() {
  if ! isTextPresentInFilodir package.yaml "$1";
  then 
    backup package.yaml && (yaml2json package.yaml | jq ".dependencies += [\"${1}\"]" | json2yaml | sponge package.yaml ) && hpack
  else
    echo "That dependency already seems present"
    return 1
  fi
}

hoogle_searchAndCopy() { wget -qO- "https://hoogle.haskell.org/?hoogle=${1}&mode=json" ;}
#!/usr/bin/env bash
# (requires docker, docker-compose)
# shellcheck disable=SC2046

docker_stopAllContainers() { sudo docker stop $(sudo docker ps -q); }
docker_stopAllContainersNonGracefully() { sudo docker kill $(sudo docker ps -q); }
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
docker_promptForRunningContainer() { sudo docker ps --format "{{.Names}}" | fzf ; }

docker_dockerComposeUp() { sudo docker-compose up ; }
docker_dockerComposeStop() { sudo docker-compose stop ; }

docker_getImageHash_sha256() { sudo docker inspect --format='{{index .RepoDigests 0}}' "$@";}

#!/usr/bin/env bash
# (requires docker, docker-compose)
kubectl_describeLastPod()    { kubectl describe pod "$(kubectl get pods --sort-by=.metadata.creationTimestamp | tail -n -1 | awk '{print $1;}')" "$@" ; }
kubectl_describePod()        { kubectl describe pod "$@" ; }
kubectl_getPods()            { kubectl get pods "$@"; }
kubectl_getAllPods()         { kubectl get pods --all-namespaces "$@"; }


kubectl_getDeployments()     { kubectl get deployments "$@"; }
kubectl_getAllDeployments()  { kubectl get deployments --all-namespaces "$@"; }

kubectl_describeService()    { kubectl describe service "$@"; }
kubectl_getServices()        { kubectl get services "$@"; }
kubectl_getAllServices()     { kubectl get services --all-namespaces "$@"; }

kubectl_describeIngress()    { kubectl describe ingress "$@"; }
kubectl_getIngress()         { kubectl get ingress "$@"; }
kubectl_getAllIngress()      { kubectl get ingress --all-namespaces "$@"; }

kubectl_getNodes()           { kubectl get nodes "$@"; }
kubectl_describeNode()        { kubectl describe node "$@" ; }

kubectl_logs()               { kubectl logs "$@"; }
kubectl_enterContainerSh()   { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" sh -c "$1" ; }
kubectl_enterContainerBash() { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" bash -c "$1" ; }

kubectl_create_byFile()           { kubectl create -f "$@"; }
kubectl_apply_byFile()           { kubectl apply -f "$@"; }
kubectl_replace_byFile()           { kubectl replace -f "$@"; }
kubectl_delete_byFile()           { kubectl delete -f "$@"; }

kubectl_getAll() {
  kubectl get nodes "$@"
  kubectl get deployments "$@"
  kubectl get daemonsets "$@"
  kubectl get pods "$@"
  kubectl get rs "$@"
  kubectl get services  "$@"
  kubectl get ingress "$@"
  kubectl get secrets "$@"
  kubectl get serviceaccounts "$@"
}
#!/usr/bin/env bash

network_findProcessUsingPort() { sudo netstat -tulpn | rg "$1" ; }
network_findProcessIdUsingPort() { sudo netstat -tlnp | awk '/:'"$1"' */ {split($NF,a,"/"); print a[1]}'; }
