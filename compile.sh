#!/usr/bin/env bash
set -x
set -e
shopt -s expand_aliases

source modules/files.sh
source modules/misc.sh

truncate -s 0 commands.sh
for var in "$@"
do
  shellcheck -e SC2164 modules/"$var".sh
  cat modules/"$var".sh >> commands.sh 
done

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

