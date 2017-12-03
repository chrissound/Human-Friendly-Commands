#!/usr/bin/env bash
set -x
shopt -s expand_aliases

source files.sh
source misc.sh

cat "$@" > commands.sh

# Extract function names
cat commands.sh | filterExcludeEmptyLines | \
  # remove lines which are comments
  \grep -v "^\s*\#" | \
  # remove anything that is not a function declaration
  \grep ".*()" | \
  # get the function name
  sed -e "s/\(.*\)().*/\1/" > commands.txt

# Extract aliases
cat commands.sh | \grep "^alias .*=" | sed -e "s/^alias \([^=]*\)=.*/\1/" >> commands.txt

chmod +x commands.sh

