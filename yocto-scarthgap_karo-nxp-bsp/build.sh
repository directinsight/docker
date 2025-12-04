docker build -t wrwdi/yocto-scarthgap_karo-nxp-bsp:latest .


## Here is a sequential list of commands to build an image in this container

## On the host configure the build directory:
# TARGET_BUILD_DIR=ddocker/volume/yocto/mickledore
# mkdir -p $HOME/$TARGET_BUILD_DIR  

## Start the container and mount the build directory on the host:
# docker run --name yocto-mickledore_karo-bsp --rm -it -v $HOME/$TARGET_BUILD_DIR:/home/yoctosdk wrwdi/yocto-mickledore_karo-bsp

## In the container, configure the BSP:
# source /bsp_config.sh
# cd karo_bsp  
# repo sync 
# DISTRO=karo-minimal MACHINE=qs93-5210 source setup-environment build-qs93-5210

## Note that you may need to run the above command twice.  

## Enable sstate cache:
# echo SSTATE_MIRRORS = \"file://.* http://sstate.karo-electronics.de/mickledore/PATH\" >> conf/local.conf 

## Build an image:     
# bitbake karo-image-minimal
