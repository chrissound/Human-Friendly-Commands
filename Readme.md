# Linux HumanFriendlyCommand

## What problem does this solve?

It is a mapping of simple function / alias names to more complicated commands. I would describe it as a list of functions that cover 80% of my common command uses.

For example:
- **makeOwnedByMyself** - `sudo chown "$USER":"$USER" -R "$@"`
- **deleteEmptyDirectories_Recursively** - `find . -type d -empty -delete`
- **git_initAndCommitInitial** - `git init; git add .; git commit -m "inital" `
- **makeZip_CurrentDirectory**  - `zip -r "$(basename "$PWD" )" . `

This also provides a benefit where you can search the list of functions names. I personally use `fzf` to fuzzy search the list - so I type 'cc' to get to the `clipboard_copyCurrentPath`. 


## Demo (quite outdated)
[![Video demo](http://img.youtube.com/vi/Rv776AD46Lc/0.jpg)](http://www.youtube.com/watch?v=Rv776AD46Lc "Video demo") 

## Installation:
Run `./compile.sh` with the modules you want available.

Example:
`./compile.sh git files`

To include everything:
`./compile.sh exa files gitWithDiffSoFancy misc gitCommon github haskell docker kubernetes`

This will generate two files:
`commands.sh` and `commands.txt`

## FZF configuration: 

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

Just create your own module file within `modules/`, it is just a shell script with functions or aliases, and then rerun `compile.sh` with your module file specified in addition.

## Available commands

- makeFilePermissionExecutable
- makeOwnedByMyself
- makeFilePermissionEverything
- getLastModifiedFileInDirectory
- get_AbsolutePath_LastModifiedFileInDirectory
- deleteEmptyFiles_Recursively
- deleteRecursive
- deleteEmptyDirectories_Recursively
- file_getOctalPermission
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
- makeZip_CurrentDirectory
- makeZip_CurrentDiretory_WithoutHidden
- findByFilename
- findByFilenameCaseInsensitive
- isTextPresentInFilodir
- pacmanInstall 
- pacmanUpdate 
- backup 
- restoreBackup 
- clipboard_copyPath 
- clipboard_copyCurrentPath 
- clipboard_copyFileContents 
- sshSocksProxy
- newEditFile
- newEditExecutableFile
- date_ddmmyyyy 
- wget_toStdOut
- wget_ignoreSslCert
- git_initAndCommitInitial
- git_DiffPager
- github_createRepo
- hpack_AddDependencyNaively
- hoogle_searchAndCopy
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
- llSortBySizeAscend
- llSortBySizeDescend
- llSortByTime
- startService
- stopService
- filterExclude
- filterOnly
- filterExcludeEmptyLines
