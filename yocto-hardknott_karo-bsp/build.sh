docker build -t wrwdi/yocto-hardknott_karo-bsp:latest .


## Here is a sequential list of commands to build an image in this container

## On the host configure the build directory:
# TARGET_BUILD_DIR=docker/volume/yocto/hardknott
# mkdir -p $HOME/$TARGET_BUILD_DIR  

## Start the container and mount the build directory on the host:
# docker run --name yocto-hardknott_karo-bsp --rm -it -v "$PWD":/home/yoctosdk wrwdi/yocto-hardknott_karo-bsp 

## In the container, configure the BSP:
# source /bsp_config.sh
# cd karo-bsp  
# repo sync 
# DISTRO=karo-minimal MACHINE=txul-5011 source setup-environment build-5011-minimal 

## Note that you may need to run the above command twice.  

## Build an image:     
# bitbake karo-image-minimal
