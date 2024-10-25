docker build -t wrwdi/yocto-hardknott_karo-bsp:latest .

## Once the container is build, run as follows
# docker run --name yocto-hardknott_karo-bsp -it --rm -v /home/armsdk/docker/volume/yocto:/home/yoctosdk wrwdi/yocto-hardknott_karo-bsp:latest

