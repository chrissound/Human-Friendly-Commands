# Human Friendly Commands

## What problem does this solve?

It as a set of functions that have a human friendly identifier, that cover 80% of my common command uses.

For example:
- **makeOwnedByMyself** - `sudo chown "$USER":"$USER" -R "$@"`
- **deleteEmptyDirectories_Recursively** - `find . -type d -empty -delete`
- **git_initAndCommitInitial** - `git init; git add .; git commit -m "inital" `
- **makeZip_CurrentDirectory**  - `zip -r "$(basename "$PWD" )" . `

This makes it convenient to search. Paired with fuzzy search, you might suddenly become so productive that you create an alternative universe in your command line.

## Installation:

### Clone the repo

### Generate the intermediate files

Run `./compile.sh` with the modules you want available.

Example:
`./compile.sh git files`

To include everything:
`./compile.sh exa files gitWithDiffSoFancy misc gitCommon github haskell docker kubernetes`

This will generate two files:
`commands.sh` and `commands.txt`

### Add intermediate files to your PATH

Add `source path/to/commands.sh` to your shell startup (`~/.bashrc` for bash). The functions and aliases will then be availble in your command prompt.

## FZF configuration: 

You may need to modify the path below to where you have actually cloned down the repo.
ZSH keybindng (bind `CTRL-Z` to `cat ~/Projects/LinuxCommandLib/commands.txt | fzf --height 25%`):

```
fzf-linuxlib-widget() {
	command=`cat ~/Projects/LinuxCommandLib/commands.txt | fzf --height 25%`
  RBUFFER=${RBUFFER}${command}
  zle redisplay
	zle end-of-line;
}

zle     -N   fzf-linuxlib-widget
bindkey '' fzf-linuxlib-widget
```

## Module files

Just create your own module file within `modules/`, it is just a shell script with functions or aliases, and then rerun `compile.sh` with your module file specified in addition.

## Available commands

### docker
- docker_stopAllContainers
- docker_stopAllContainersNonGracefully
- docker_deleteComposeVolumes
- docker_showLatestCreatedContainer
- docker_getLatestCreatedContainerId
- docker_startLatestCreatedContainer
- docker_listContainers
- docker_listRunningContainers
- docker_listRunningContainerIps
- docker_enterContainerBash
- docker_enterContainerSh
- docker_runCommandInContainer
- docker_runCommandInContainerWithContainerPrompt
- docker_promptForRunningContainer
- docker_dockerComposeUp
- docker_dockerComposeStop
- docker_getImageHash_sha256
### exa
### files
- makeFilePermissionExecutable
- makeOwnedByMyself
- makeFilePermissionEverything
- getLastModifiedFileInDirectory
- get_AbsolutePath_LastModifiedFileInDirectory
- delete_EmptyFiles_Recursively
- delete_Recursive
- delete_EverythingInCurrentDir
- delete_EmptyDirectories_Recursively
- file_getOctalPermission
- createFile
- vimLastDownloadedFile
### gitCommon
- git_initAndCommitInitial
- git_DiffPager
- git_searchCommitMessagesInAllBranches
- git_forceClone
### github
- github_createRepo
### git
- git_cdRoot
- git_ExportRepoAsZip
- git_AddModified_Commit_Push
- git_CurrentCommitHash
- git_CurrentCommitHash_ToClipboard
- git_Branch
- git_Diff
- git_Status
- git_Log
- git_Log_NameOnly
- git_ResetToLatest
- git_checkoutPaths
- git_FirstCommitHash
### gitWithDiffSoFancy
- git_cdRoot
- git_ExportRepoAsZip
- git_AddModified_Commit_Push
- git_CurrentCommitHash
- git_CurrentCommitHash_ToClipboard
- git_Branch
- git_Diff
- git_Status
- git_Log
- git_Log_NameOnly
- git_ResetToLatest
- git_checkoutPaths
- git_FirstCommitHash
### haskell
- hpack_AddDependencyNaively
- hoogle_searchAndCopy
### kubernetes
- kubectl_describeLastPod
- kubectl_describePod
- kubectl_getPods
- kubectl_getAllPods
- kubectl_getDeployments
- kubectl_getAllDeployments
- kubectl_describeService
- kubectl_getServices
- kubectl_getAllServices
- kubectl_describeIngress
- kubectl_getIngress
- kubectl_getAllIngress
- kubectl_getNodes
- kubectl_describeNode
- kubectl_logs
- kubectl_enterContainerSh
- kubectl_enterContainerBash
- kubectl_create_byFile
- kubectl_apply_byFile
- kubectl_replace_byFile
- kubectl_delete_byFile
- kubectl_getAll
### misc
- makeZip_CurrentDirectory
- makeZip_CurrentDiretory_WithoutHidden
- makeGZip_CurrentDirectory
- findByFilename
- findByFilenameCaseInsensitive
- isTextPresentInFilodir
- pacmanInstall 
- pacmanUpdate 
- backup 
- backup_appendWithDate 
- backup_appendWithTimeDate 
- restoreBackup 
- clipboard_copyPath 
- clipboard_copyCurrentPath 
- clipboard_copyFileContents 
- sshSocksProxy
- newEditFile
- newEditExecutableFile
- date_ddmmyyyy 
- date_hhmmssddmmyyyy 
- wget_toStdOut
- wget_ignoreSslCert
- file_delete_line
- print_everyPathLevel_ofPath
### networking
- network_findProcessUsingPort
- network_findProcessIdUsingPort
