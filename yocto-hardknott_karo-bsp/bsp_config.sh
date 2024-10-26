#!/bin/bash

git config --global user.name "yoctosdk"
git config --global user.email "yoctosdk@yoctosdk.com" 
git config --global color.ui auto
mkdir /home/yoctosdk/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/yoctosdk/bin/repo
chmod a+x /home/yoctosdk/bin/repo
## The PATH is also set in /etc/profile
echo "export PATH=~/bin:$PATH" > /home/yoctosdk/.bashrc
export PATH=~/bin:$PATH
mkdir /home/yoctosdk/karo-bsp
cd /home/yoctosdk/karo-bsp
~/bin/repo init -u https://github.com/karo-electronics/karo-bsp -b hardknott
~/bin/repo sync
