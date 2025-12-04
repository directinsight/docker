## Dockerfile for karo-nxp-bsp Yocto Scarthgap
## https://hub.docker.com/r/wrwdi/yocto-scarthgap_karo-nxp-bsp

## Create a file called Dockerfile containing this text and add to a directory on your host
## Now Run this Dockerfile with the command below in the same directory as the Dockerfile:
## docker build -t <Docker IMAGE Name> .
## Final image name should be "wrwdi/yocto-scarthgap_karo-nxp-bsp:latest"
## => docker build -t wrwdi/yocto-scarthgap_karo-nxp-bsp:latest .

## Start build
FROM ubuntu:24.04
RUN apt-get update
RUN apt-get install -y build-essential chrpath cpio debianutils diffstat file gawk gcc git \
iputils-ping libacl1 liblz4-tool locales python3 python3-git python3-jinja2 python3-pexpect \
python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd python-is-python3 nano curl sudo

RUN locale-gen en_US.UTF-8

# Need to change default user, ubuntu in Ubuntu 24.04 to yoctosdk:
# https://askubuntu.com/questions/1513927/ubuntu-24-04-docker-images-now-includes-user-ubuntu-with-uid-gid-1000
RUN usermod -l yoctosdk ubuntu && \
    usermod -m -d /home/yoctosdk yoctosdk && \
    groupmod -n yoctosdk ubuntu && \
    echo 'yoctosdk:yoctosdk' | chpasswd && \
    usermod -aG sudo yoctosdk

COPY bsp_config.sh /bsp_config.sh
# Make sure no "/r" just in case the script is created on a Windows editor
RUN apt-get install -y dos2unix && \
    dos2unix /bsp_config.sh && \
    apt-get remove --purge -y dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod a+xr /bsp_config.sh

USER yoctosdk
WORKDIR /home/yoctosdk    
SHELL ["/bin/bash", "-c"]

