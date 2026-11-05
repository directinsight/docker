Note: user/pass for running BSP builds is **yoctosdk/yoctosdk**.    
  
Create an empty directory on the host, for example: **~/docker-karo-bsp/hardknott**.      
This is where the images will be built and will persist if the container is deleted:       

```
host> mkdir -p ~/docker-karo-bsp/hardknott  
host> cd ~/docker-karo-bsp/hardknott
```

Download the docker image and run the container:

```
host> docker run --name yocto-hardknott_karo-bsp --rm -it -v ./:/home/yoctosdk wrwdi/yocto-hardknott_karo-bsp  
```

The **/home/yoctosdk** directory inside the container will be mounted as a docker volume (**~/docker-karo-bsp/hardknott**) on the host.  
  
The **--rm** option ensures that the docker container is removed when you exit the container, so you don't have to remember to clean up. If you wish the container to persist do not use the **--rm** option.    
  
If you wish to build the image within the container rather than in the mounted docker volume on the host, simply remove the **-v ./:/home/yoctosdk** option:  

```
host> docker run --name yocto-hardknott_karo-bsp --rm -it wrwdi/yocto-hardknott_karo-bsp
```
  
You will now be in a **bash** shell in the running container as user **yoctosdk**.       
  
Configure the TX6 Yocto Hardknott BSP by running the following scripts in the container:  
  
```
container> source /bsp_config.sh 
container> repo sync
```
  
The Yocto Hardknott BSP is initialized in **~/karo-bsp** in the container, which is a mounted docker volume **~/docker-karo-bsp/hardknott/karo-bsp** on the host.      
  
Setup the build environment in the container for the required Yocto distro, module and target recipe for example forom the **karo-bsp** directory:    
  
```
container> DISTRO=karo-minimal MACHINE=txul-5011 source setup-environment build-5011-minimal
```
  
Note that you will need to run the above command twice. You will now be in the Yocto build sub-directory. In this example **build-5011-minimal**.    
  
The BSP has not been updated since May 2024 so modifications to some of the Yocto recipes are required. Run the following commands from the **~/karo-bsp/build-5011-minimal** directory.  

```
container> source /bsp_fix_recipe.sh
```  

You can check the details of the changes by examining the script and modify if necessary before running it:    

```
container> nano /bsp_fix_recipe.sh
```  
  
Now you can build the target image, for example:  

```  
container> bitbake karo-image-minimal
```

Notice that Yocto configuration files in the **conf** directory can either be modified from the container using the `nano` editor or from the host using your preferred editor.    

If you get build errors assocoated with a **do_fetch** (eg "ERROR: libpcre-native-8.44-r0 do_fetch: Fetcher failure") or simular simply run `bitbake` again. It may be necessary to do this several times before you get a clean build but it should eventually build. It is not unusual for the source of the download to sometimes go offline for a short period of time. If the build continues to fail then it will be necessary to find where the source has move to and edit the recipe ( see **/bsp_fix_recipe.sh** as an example).    

If you get build errors associated with a **do_compile** (eg `sources/poky/meta/recipes-devtools/gcc/gcc-cross_13.4.bb:do_compile failed with exit code '1'`), this can be due to a corrupt download. You should clean the download and try the build again. Run the following commands and build again:    

```
container> bitbake -c cleansstate gcc-cross 
container> bitbake -c cleanall gcc-cross 
```

If you exit the container it will automatically be removed, however the build directory will persist on the host. If you need to modify the build, simply run the `docker run ....` command above and type the following in the container to setup the correct environment for the Yocto builds:    

```
container> cd ~/karo-bsp
container> source setup-environment build-5011-minimal
``` 
 
See the Karo documentation on Yocto for more details on builds:  
https://karo-electronics.github.io/docs/yocto-guide/mainline/setup.html  
  
After the image is built, it is safe to exit and/or delete the container. The build directory will persist on the host:  
**~/docker-karo-bsp/hardknott**  

  
  
  
    
  
### Additional documentation  
https://github.com/directinsight/docker/tree/master/yocto-hardknott_karo-bsp  






