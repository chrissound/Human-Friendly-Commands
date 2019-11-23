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
