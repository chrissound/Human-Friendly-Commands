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

hoogle_searchAndCopy() {
  wget -qO- https://hoogle.haskell.org/\?hoogle\="$1"\&scope\=set%3Astackage\&mode\=json \
    | jq -r ".[] | \"import \\(.module.name)\\n\\(.package.name)\\n--\"" \
    | fzf | xclip ;
  }
