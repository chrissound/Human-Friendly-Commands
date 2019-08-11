#!/usr/bin/env bash
set -x
set -e
shopt -s expand_aliases

source modules/files.sh
source modules/misc.sh

truncate -s 0 readmeGenerate.md

for var in $(ls -1 modules)
do
    var=$(basename "$var" .sh)
    echo -n "### " >> readmeGenerate.md
    echo "$var" >> readmeGenerate.md
    cat modules/"$var".sh | filterExcludeEmptyLines | \
        # remove lines which are comments
        \grep -v "^\s*\#" | \
            # remove anything that is not a function declaration
        \grep ".*()" | \
            # get the function name
        sed -e "s/\(.*\)().*/- \1/" >> readmeGenerate.md
done
