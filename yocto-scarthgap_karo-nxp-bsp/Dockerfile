## Dockerfile for karo-nxp Hardknott

## https://hub.docker.com/r/wrwdi/yocto-scarthgap_karo-bsp

## Create a file called Dockerfile containing this text and add to a directory on your host
## Now Run this Dockerfile with the command below in the same directory as the Dockerfile:
## docker build -t <Docker IMAGE Name> .
## Final image name should be "wrwdi/yocto-scarthgap_karo-bsp:latest"
## => docker build -t wrwdi/yocto-scarthgap_karo-bsp:new

## Start build
FROM ubuntu:24.04
# Need to change default ubuntu user to yoctosdk:
# https://askubuntu.com/questions/1513927/ubuntu-24-04-docker-images-now-includes-user-ubuntu-with-uid-gid-1000
#RUN userdel -r ubuntu
#RUN useradd -ms /bin/bash yoctosdk && \
#    echo 'yoctosdk:yoctosdk' | chpasswd && \
#    usermod -aG sudo yoctosdk
RUN usermod -l yoctosdk ubuntu
RUN usermod -m -d /home/yoctosdk yoctosdk
RUN groupmod -n yoctosdk ubuntu

RUN apt-get update
RUN apt-get install -y build-essential chrpath cpio debianutils diffstat file gawk gcc git
RUN apt-get install -y iputils-ping libacl1 liblz4-tool locales python3 python3-git python3-jinja2 python3-pexpect
RUN apt-get install -y python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd python-is-python3
RUN apt-get install -y nano curl

RUN locale-gen en_US.UTF-8
RUN apt install -y sudo

COPY bsp_config.sh /bsp_config.sh
RUN apt-get install -y dos2unix && \
    dos2unix /bsp_config.sh && \
    apt-get remove --purge -y dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN chmod a+xr /bsp_config.sh

## The below cmmmands all done in the "bsp_config.sh" script which the user should run at first login
    	
#RUN git config --global user.name "yoctosdk" && \
#    git config --global user.email "yoctosdk@yoctosdk.com" && \
#    git config --global color.ui auto
    
#    mkdir /home/yoctosdk/bin && \
#    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/yoctosdk/bin/repo && \
#    chmod a+x /home/yoctosdk/bin/repo && \
#    echo "export PATH=~/bin:$PATH" >> /home/yoctosdk/.bashrc && \
#    export PATH=~/bin:$PATH && \
#    mkdir /home/yoctosdk/karo-bsp && \
#    cd /home/yoctosdk/karo-bsp && \
#    ../bin/repo init -u https://github.com/karo-electronics/karo-bsp -b hardknott && \
#    ../bin/repo sync

USER yoctosdk

WORKDIR /home/yoctosdk    
SHELL ["/bin/bash", "-c"]

