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
  echo
  echo "*************************************************"
  echo "**************** GIT DIFF CACHED ****************"
  echo "*************************************************"
  echo
  git --no-pager diff --stat --cached
  echo
  git --no-pager diff --cached --color | diff-so-fancy

}
git_Status() { git status | tac; }
git_Log() { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit ; }
git_Log_NameOnly() { git log --name-only "$@" ; }
git_ResetToLatest() { git reset --hard HEAD; }
git_checkoutPaths() { git checkout -- "$@" }
