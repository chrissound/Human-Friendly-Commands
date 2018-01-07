#!/usr/bin/env bash

# Create a repo named by the current directory
# Accepts 1 STRING parameter for the repo description
# Depends on: jq
github_createRepo() {
  projName="$(basename "$PWD")"
  json=$(jq -n \
    --arg name "$projName" \
    --arg description "$1" \
    '{"name":$name, "description":$description}')

  curl -u "$GITHUB_USER":"$GITHUB_PASSWORD" https://api.github.com/user/repos -d "$json"
  git init
  git remote add origin git@github.com:"$GITHUB_USER"/"$projName".git
  git push origin master
};

