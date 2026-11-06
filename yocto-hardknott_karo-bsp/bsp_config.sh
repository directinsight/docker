#!/bin/bash

git config --global user.name "yoctosdk"
git config --global user.email "yoctosdk@yoctosdk.com" 
git config --global color.ui auto
mkdir -p $HOME/bin
curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo -o "$HOME/bin/repo"
chmod a+x $HOME/bin/repo
echo 'export PATH=~/bin:$PATH' >> $HOME/.bashrc
export PATH=~/bin:$PATH
cd "$HOME/work"
#repo init -u https://github.com/karo-electronics/karo-bsp -b hardknott
repo init -u https://github.com/karo-electronics/karo-bsp -b refs/tags/KARO-2022-07-14
repo sync
