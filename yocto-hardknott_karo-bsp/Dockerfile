## Dockerfile for karo-nxp Hardknott

## https://hub.docker.com/r/wrwdi/yocto-hardknott_karo-bsp

## Create a file called Dockerfile containing this text and add to a directory on your host
## Now Run this Dockerfile with the command below in the same directory as the Dockerfile:
## docker build -t <Docker IMAGE Name> .
## Final image name should be "wrwdi/yocto-hardknott_karo-bsp:latest"

## It is safe to ignore error messages:
## "debconf: delaying package configuration, since apt-utils is not installed"
## "warning: Setting locale failed"


## Yocto Requirements for Hardknott:
## <https://docs.yoctoproject.org/3.3.2/ref-manual/system-requirements.html#supported-linux-distributions>
## sudo apt-get install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils 
## debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev

## Start build
FROM ubuntu:20.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gawk wget git diffstat unzip 
RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y texinfo 
RUN apt-get install -y gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git && \
    apt-get install -y python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev curl nano sudo

#RUN dpkg-reconfigure locales <select 159. en_US.UTF-8 UTF-8>
## For noninteractive see: <https://serverfault.com/questions/362903/how-do-you-set-a-locale-non-interactively-on-debian-ubuntu>:

ENV LANG=en_US.UTF-8
RUN apt-get install -y locales && \
    echo "$LANG UTF-8" > /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG && \   
    useradd -ms /bin/bash yoctosdk && \
    echo 'yoctosdk:yoctosdk' | chpasswd && \
    usermod -aG sudo yoctosdk
    
## The above generates warnings about "Setting locale failed" beut it still seems to work okay
   
COPY bsp_config.sh /bsp_config.sh
RUN chmod a+xr /bsp_config.sh && \
    echo "export PATH=~/bin:$PATH" >> /etc/profile   

## Note need to add the correct path for repo to /etc/profile since it does not get read correctly in the .bashrc, see:
## <https://stackoverflow.com/questions/55206227/why-bashrc-is-not-executed-when-run-docker-container>
    
USER yoctosdk

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

WORKDIR /home/yoctosdk    
SHELL ["/bin/bash", "-c"]
#CMD ["/bin/bash"]

