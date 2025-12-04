#!/bin/bash

git config --global user.name "yoctosdk"
git config --global user.email "yoctosdk@yoctosdk.com" 
git config --global color.ui auto
mkdir $HOME/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/yoctosdk/bin/repo
chmod a+x $HOME/bin/repo
echo "export PATH=~/bin:$PATH" > $HOME/.bashrc
export PATH=~/bin:$PATH
mkdir $HOME/karo-bsp
cd $HOME/karo-bsp
repo init -u https://github.com/karo-electronics/karo-nxp-bsp -b scarthgap
repo sync
