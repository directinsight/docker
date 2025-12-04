Note: user/pass for running BSP builds is **yoctosdk/yoctosdk**.    
  
Create an empty mount point on the host: **$HOME/$YOCTO_BSP_DIR**. See instructions below.  
**$YOCTO_BSP_DIR** is where the images will be built and will persist even if the container is deleted (see example below).       
  
Using the following commands from a **bash** shell on your Linux host machine, setup the **YOCTO_BSP_DIR** along with the docker container.  
You can change the **YOCTO_BSP_DIR** to whatever you wish:  
       
`YOCTO_BSP_DIR=docker/volume/yocto/scarthgap`   
`mkdir -p $HOME/$YOCTO_BSP_DIR`
`docker pull wrwdi/yocto-scarthgap_karo-nxp-bsp`   
`docker run --name yocto-scarthgap_karo-nxp-bsp --rm -it -v $HOME/$YOCTO_BSP_DIR:/home/yoctosdk wrwdi/yocto-scarthgap_karo-nxp-bsp`  
  
The **--rm** option ensures that the docker container is removed when you exit the container, so you don't have to remember to clean up. If you wish the container to persist do not use the **--rm** option.    
  
If you wish to build the image within the container rather than on the mount point in the host, simply remove the **-v** option:  
`docker run --name yocto-scarthgap_karo-nxp-bsp --rm -it wrwdi/yocto-scarthgap_karo-nxp-bsp`  
  
You will now be in a **bash** shell in the running container as user **yoctosdk**.       
  
Configure the TX6 Yocto scarthgap BSP by running the following scripts in the container:  
  
`source /bsp_config.sh`   
`repo sync`  
  
The Yocto scarthgap BSP is initialised in **$HOME/YOCTO_BSP_DIR**.    
  
Setup the build environment in the container for the required Yocto distro, module, baseboard and targer recipe for example form the **karo-bsp** directory:    

`DISTRO=karo-minimal MACHINE=tx93-5210 KARO_BASEBOARD=lvds-mb source karo-setup-release.sh -b build-tx93-5210`  
  
Now you can build the target image, for example:  
  
`bitbake karo-image-minimal`

Note:
* The user/pass for running BSP builds is **yoctosdk/yoctosdk**, although you should not need it.   
* Thee Yocto configuration files in the **conf** sub-director of the build directory **build-tx93-5210** can either be modified from within the container using the `nano` editor or from the host using your preferred editor.    
* If you get build errors assocoated with a **do_fetch** (eg "ERROR: libpcre-native-8.44-r0 do_fetch: Fetcher failure") or simular simply run `bitbake` again. It may be necessary to do this several times before you get a clean build but it should eventually build. It is not unusual for the source of the download to sometimes go offline for a short period of time. If the build continues to fail then it will be necessary to find where the source has move to and edit the recipe ( see **/bsp_fix_recipe.sh** as an example).    
* If you get build errors associated with a **do_compile** (eg "sources/poky/meta/recipes-devtools/gcc/gcc-cross_13.4.bb:do_compile failed with exit code '1'"), this can be due to a currupt download. You should clean the download and try the build again. Run the following commands and build again:  
`bitbake -c cleansstate gcc-cross`  
`bitbake -c cleanall gcc-cross`  

If you exit the container it will automatically be removed, however the build directory will persist on the host. If you need to modify the build, simply run the `docker run ....` command above and type the following in the container to setup the correct environment for the Yocto builds:    
 
`cd ~/karo-bsp`   
`source setup-environment build-5011-minimal`  
 
See the Karo documentation on Yocto for more details on builds:  
https://karo-electronics.github.io/docs/yocto-guide/mainline/setup.html  
  
After the image is built, it is safe to exit and/or delete the container. The build directory will persist on the host:  
**/home/armsdk/docker/volume/yocto/karo-bsp**  

  
  
  
    
  
### Additional documentation  
https://github.com/directinsight/docker/tree/master/yocto-scarthgap_karo-nxp-bsp  






