#!/usr/bin/env bash

git_initAndCommitInitial() { git init; git add .; git commit -m "inital" ;}
git_DiffPager() { git_Diff | less ; }
git_searchCommitMessagesInAllBranches() { git log --all --grep="$1" }
