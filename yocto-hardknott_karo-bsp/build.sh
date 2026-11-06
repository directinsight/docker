docker build -t wrwdi/yocto-hardknott_karo-bsp:latest .


## Here is a sequential list of commands to build a tx6 yocto image in this container

## Start the container and mount the build directory on the host:
# docker run --name yocto-hardknott_karo-bsp --rm -it -v "$PWD":/home/yoctosdk/work wrwdi/yocto-hardknott_karo-bsp 

## In the container, configure the BSP:
# source ~/bsp_config.sh

# DISTRO=karo-minimal MACHINE=txul-5011 source setup-environment build-5011-minimal 

## Note that you may need to run the above command twice.  

## BSP fixes required:
# source ~/bsp_fix_recipe.sh

## Build an image:     
# bitbake karo-image-minimal
