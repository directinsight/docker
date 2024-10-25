#docker build -t yocto:hardknott_test-v1 .
docker build -t wrwdi/yocto-hardknott_karo-bsp:latest .

# docker run --name yocto-hardknott_karo-bsp -it --rm --workdir /home/yoctosdk -v /home/armsdk/docker/volume/yocto:/home/yoctosdk wrwdi/yocto-hardknott_karo-bsp:latest


## Tests
## -----

## run sudo connands eg "sudo su"
## Exit container removes it
## Path setup correctly even after second attach

