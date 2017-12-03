#!/usr/bin/env bash
set -x

source misc.sh

cat "$@" > commands.sh
cat commands.sh | filterExcludeEmptyLines | grep -v "^\s*\#" | grep ".*\(\)" | sed -e "s/\(.*\)().*/\1/" > commands.txt
chmod +x commands.sh

