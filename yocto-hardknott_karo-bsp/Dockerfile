## Dockerfile for karo-nxp Hardknott

## https://hub.docker.com/r/wrwdi/yocto-hardknott_karo-bsp

## Create a file called Dockerfile containing this text and add to a directory on your host along with the two scripts
## bsp_config.sh and bsp_fix_recipe.sh. Now Run this Dockerfile with the command below in the same directory as the Dockerfile:
## docker build --tag <Docker IMAGE Name> .
## Final image name should be "wrwdi/yocto-hardknott_karo-bsp:<TAG>"  
## Example (note the "." at the end of the command):
## docker build --tag wrwdi/yocto-hardknott_karo-bsp:next .

## Yocto Requirements for Hardknott:
## <https://docs.yoctoproject.org/3.3.2/ref-manual/system-requirements.html#supported-linux-distributions>
## sudo apt-get install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils 
## debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev

## Start build
FROM ubuntu:20.04@sha256:8feb4d8ca5354def3d8fce243717141ce31e2c428701f6682bd2fafe15388214
LABEL org.opencontainers.image.title="yocto-hardknott_karo-bsp" \
      org.opencontainers.image.description="Build environment for the Karo TX6 Yocto hardknott BSP" \
      org.opencontainers.image.source="https://github.com/directinsight/docker/tree/master/yocto-hardknott_karo-bsp" \
      org.opencontainers.image.base.name="ubuntu:20.04"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ="Europe/London" apt-get install -y --no-install-recommends \
        ca-certificates curl file gawk wget git diffstat unzip texinfo gcc build-essential \
        chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
        python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit \
        mesa-common-dev locales nano sudo && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8


ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd -g ${USER_GID} yoctosdk && \
    useradd -m -s /bin/bash -u ${USER_UID} -g ${USER_GID} yoctosdk && \
    echo 'yoctosdk:yoctosdk' | chpasswd && \
    usermod -aG sudo yoctosdk

RUN curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo && \
    chmod a+rx /usr/local/bin/repo
    
COPY --chown=yoctosdk:yoctosdk --chmod=755 bsp_config.sh bsp_fix_recipe.sh /home/yoctosdk/
    
USER yoctosdk
RUN mkdir -p /home/yoctosdk/work && \
    git config --global user.name "yoctosdk" && \
    git config --global user.email "yoctosdk@yoctosdk.com" && \
    git config --global color.ui auto

WORKDIR /home/yoctosdk/work   
SHELL ["/bin/bash", "-c"]


