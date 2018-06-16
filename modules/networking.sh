#!/usr/bin/env bash

network_findProcessUsingPort() { sudo netstat -tulpn | rg "$1" ; }
network_findProcessIdUsingPort() { sudo netstat -tlnp | awk '/:'"$1"' */ {split($NF,a,"/"); print a[1]}'; }
