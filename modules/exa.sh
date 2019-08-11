#!/usr/bin/env bash

# Dependencies: exa

#listFiles
alias listDirectoryContentsSortByAlphabeticallyAscend="exa -l --group-directories-first"
alias listDirectoryContentsSortBySizeAscend="exa -l --group-directories-first --sort=size"
alias listDirectoryContentsSortBySizeDescend="exa -l --group-directories-first --sort=size -r"
alias listDirectoryContentsSortByTimeAscend="exa -l --group-directories-first --sort=modified"
alias listDirectoryContentsSortByTimeDescend="exa -l --group-directories-first --sort=modified -r"

