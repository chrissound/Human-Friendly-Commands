# Linux Command Lib

## What problem does this solve?
It's just a collection of verbose commands that abstract away all the more complicated commands.

For example to zip the contents of the current directory it's just `makeZip` instead of `zip -r filename.zip .`, and `makeOwnedByMyself filename` instead of `sudo chown $USER:$USER -R filname`.

If you use this with FZF, you only can fuzzily search for a command. For example `mz` for `MakeZip`.

## Demo
[![Video demo](http://img.youtube.com/vi/Rv776AD46Lc/0.jpg)](http://www.youtube.com/watch?v=Rv776AD46Lc "Video demo") 

## Dependencies:
- fzf

## Installation: 
Run `./compile.sh` with the module files you want available.
Example:
`./compile.sh git.sh files.sh`

To include everything:
`./compile.sh exa.sh files.sh gitWithDiffSoFancy.sh misc.sh gitCommon.sh github.sh`

This will generate two files:
`commands.sh` and `commands.txt`

Add `commands.sh` to your PATH. The functions and aliases will then be availble in your command prompt.

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
 - misc.sh
 - exa.sh
 - files.sh
 - git.sh
 - gitWithDiffSoFancy.sh

## Extending
Just create your own module file, which is just a shell script with functions, and then rerun `compile.sh` with your module file specified in addition.

## Available commands

- makeFilePermissionExecutable
- makeOwnedByMyself
- makeFilePermissionEverything
- getLastModifiedFileInDirectory
- get_AbsolutePath_LastModifiedFileInDirectory
- deleteEmptyFiles_Recursively
- deleteRecursive
- deleteEmptyDirectories_Recursively
- makeZip_CurrentDirectory
- makeZip_CurrentDiretory_WithoutHidden
- findByFilename
- findByFilenameCaseInsensitive
- docker_stopAllContainers
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
- kubectl_DescribeLastPod
- kubectl_GetPods
- kubectl_GetSvc
- kubectl_GetDeployments
- kubectl_GetNodes
- kubectl_EnterContainer
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
- gitResetToLatest
- pacmanInstall 
- pacmanUpdate 
- backup 
- restoreBackup 
- copyPathToClipboard 
- copyFileToClipboard 
- sshSocksProxy
- newEditFile
- newEditExecutableFile
