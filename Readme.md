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
Add `commands.sh` to your PATH. The functions and aliases will then be availble in your command prompt.

ZSH keybindng (bind `cat ~/Projects/LinuxCommandLib/commands.txt | fzf --height 25%` to `CTRL-Z`):

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


## Extending
If you modify the `commands.sh` file you can generate the corresponding `commands.txt` file with the below:

    source commands.sh
    cat commands.sh | filterExcludeEmptyLines | grep -v "^\s*\#" | grep ".*\(\)" | sed -e "s/\(.*\)().*/\1/"

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
