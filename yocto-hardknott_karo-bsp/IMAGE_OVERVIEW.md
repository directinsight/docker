Note: user/pass for running BSP builds is **yoctosdk/yoctosdk**.    
  
Create an empty mount point on the host: **$HOME/$YOCTO_BSP_DIR**.       
**$YOCTO_BSP_DIR** is where the images will be built and will persist even if the container is deleted (see example below).       
  
Setup the **YOCTO_BSP_DIR** on the host and the container from this docker image by running the following commands on the host.  
You can change the **YOCTO_BSP_DIR** to whatever you wish:  
       
`YOCTO_BSP_DIR=docker/volume/yocto/hardknott`   
`mkdir -p $HOME/$YOCTO_BSP_DIR`
`docker pull wrwdi/yocto-hardknott_karo-bsp`   
`docker run --name yocto-hardknott_karo-bsp --rm -it -v $HOME/$YOCTO_BSP_DIR:/home/yoctosdk wrwdi/yocto-hardknott_karo-bsp` 
  
The **--rm** option ensures that the docker container is removed when you exit the container, so you don't have to remember to clean up. If you wish the container to persist do not use the **--rm** option.    
  
If you wish to build the image within the container rather than on the mount point in the host, simply remove the **-v** option:  
`docker run --name yocto-hardknott_karo-bsp --rm -it wrwdi/yocto-hardknott_karo-bsp`  
  
You will now be in a **bash** shell in the running container as user **yoctosdk**.       
  
Configure the TX6 Yocto Hardknott BSP by running the following scripts in the container:  
  
`source /bsp_config.sh`   
`repo sync`  
  
The Yocto Hardknott BSP is initialised in **$HOME/YOCTO_BSP_DIR**.    
  
Setup the build environment in the container for the required Yocto distro, module and targer recipe for example form the **karo-bsp** directory:    
  
`DISTRO=karo-minimal MACHINE=txul-5011 source setup-environment build-5011-minimal`  
  
Note that you will need to run the above command twice. You will now be in the Yocto build sub-directory. In this example **build-5011-minimal**.    
  
The BSP has not been updated since May 2024 so modifications to some of the Yocto recepies are required. Run the following commands from the **build-5011-minimal**.  

`/source/bsp_fix_recipe.sh`  
  
There is no sstate cache for the hardknott branch on Karo's sstate mirror; remove it from the **local.conf** file:  
  
`sed -i '19,21d' conf/local.conf`  
  
Some GitHub repos have changed from master to main branch. Update the affected repos as follows:    
  
`sed -i 's\git://github.com/KhronosGroup/SPIRV-Headers;protocol=https\git://github.com/KhronosGroup/SPIRV-Headers;protocol=https;branch=main\g' ../layers/poky/meta/recipes-graphics/spir/spirv-headers_1.5.4.bb`      

`sed -i 's\git://github.com/KhronosGroup/SPIRV-Tools.git \git://github.com/KhronosGroup/SPIRV-Tools.git;branch=main \g' ../layers/poky/meta/recipes-graphics/spir/spirv-tools_2020.7.bb`    

`sed -i 's\git://github.com/KhronosGroup/glslang.git;protocol=https\git://github.com/KhronosGroup/glslang.git;protocol=https;branch=main\g' ../layers/poky/meta/recipes-graphics/glslang/glslang_11.2.0.bb`     

`sed -i 's\git://github.com/KhronosGroup/Vulkan-Loader.git\git://github.com/KhronosGroup/Vulkan-Loader.git;branch=main\g' ../layers/poky/meta/recipes-graphics/vulkan/vulkan-loader_1.2.170.0.bb`     

Other Recipe changes:  

`sed -i 's\https://ftp.pcre.org/pub/pcre/pcre-${PV}.tar.bz2\https://sourceforge.net/projects/pcre/files/pcre/8.44/pcre-8.44.tar.bz2\g' ../layers/poky/meta/recipes-support/libpcre/libpcre_8.44.bb`    

`sed -i 's\${SOURCEFORGE_MIRROR}/expat/expat-${PV}.tar.bz2\https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.bz2\g' ../layers/poky/meta/recipes-core/expat/expat_2.2.10.bb`  

  
The **/etc/fstab** file is incorrect for the TXUL and TX6 range of modules. Update it:    
  
`sed -i 's\PARTLABEL=rootfs\PARTUUID=0cc66cc0-02\g' ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab`  

`sed -i 's\PARTLABEL=boot\PARTUUID=0cc66cc0-01\g' ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab`  
  
Now you can build the target image, for example:  
  
`bitbake karo-image-minimal`
  
If you get build errors (eg "ERROR: libpcre-native-8.44-r0 do_fetch: Fetcher failure" or simular) simply run `bitbake` again. It may be necessary to do this several times before you get a clean build but it should eventually build.  

Notice that Yocto configuration files can either be modified from the container using the `nano` editor or from the host using your preferred editor.  
  
If you exit the container it will automatically be removed, however the build directory will persist on the host. If you need to modify the build, simply run the `docker run ....` command above and type the following in the container to setup the correct environment for the Yocto builds:    
 
`cd ~/karo-bsp`   
`source setup-environment build-5011-minimal`  
 
See the Karo documentation on Yocto for more details on builds:  
https://karo-electronics.github.io/docs/yocto-guide/mainline/setup.html  
  
After the image is built, it is safe to exit and/or delete the container. The build directory will persist on the host:  
**/home/armsdk/docker/volume/yocto/karo-bsp**  

  
  
  
    
  
### Additional documentation  
https://github.com/directinsight/docker/tree/master/yocto-hardknott_karo-bsp  






