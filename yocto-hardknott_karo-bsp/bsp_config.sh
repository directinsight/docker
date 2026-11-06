#!/bin/bash

cd "$HOME/work" || { echo "Cannot cd to $HOME/work"; return 1 2>/dev/null || exit 1; }
repo init -u https://github.com/karo-electronics/karo-bsp -b refs/tags/KARO-2022-07-14
repo sync
