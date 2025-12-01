#!/bin/bash

#Fix fstab for TX6 (done for archive BSP):
#/home/armsdk/yocto/karo-bsp/hardknott/layers/meta-karo-distro/recipes-core/base-files/base-files/fstab
#cp fstab fstab.old
sed -i 's\PARTLABEL=rootfs\PARTUUID=0cc66cc0-02\g' ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab
sed -i 's\PARTLABEL=boot\PARTUUID=0cc66cc0-01\g' ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab

#/home/armsdk/yocto/karo-bsp/hardknott/layers/poky/meta/recipes-graphics/spir/spirv-headers_1.5.4.bb
#cp spirv-headers_1.5.4.bb spirv-headers_1.5.4.oldbb
#SRC_URI = "git://github.com/KhronosGroup/SPIRV-Headers;protocol=https;branch=main"

sed -i 's\git://github.com/KhronosGroup/SPIRV-Headers;protocol=https\git://github.com/KhronosGroup/SPIRV-Headers;protocol=https;branch=main\g' ../layers/poky/meta/recipes-graphics/spir/spirv-headers_1.5.4.bb

#/home/armsdk/yocto/karo-bsp/hardknott/layers/poky/meta/recipes-graphics/spir/spirv-tools_2020.7.bb
#cp spirv-tools_2020.7.bb spirv-tools_2020.7.oldbb
#SRC_URI = "git://github.com/KhronosGroup/SPIRV-Tools.git;branch=main

sed -i 's\git://github.com/KhronosGroup/SPIRV-Tools.git\git://github.com/KhronosGroup/SPIRV-Tools.git;branch=main \g' ../layers/poky/meta/recipes-graphics/spir/spirv-tools_2020.7.bb

#/home/armsdk/yocto/karo-bsp/hardknott/layers/poky/meta/recipes-graphics/glslang/glslang_11.2.0.bb
#cp glslang_11.2.0.bb glslang_11.2.0.oldbb 
#SRC_URI = "git://github.com/KhronosGroup/glslang.git;protocol=https;branch=main

sed -i 's\git://github.com/KhronosGroup/glslang.git;protocol=https\git://github.com/KhronosGroup/glslang.git;protocol=https;branch=main\g' ../layers/poky/meta/recipes-graphics/glslang/glslang_11.2.0.bb

#/home/armsdk/yocto/karo-bsp/hardknott/layers/poky/meta/recipes-graphics/vulkan/vulkan-loader_1.2.170.0.bb:do_fetch
#cp vulkan-loader_1.2.170.0.bb vulkan-loader_1.2.170.0.oldbb
#SRC_URI = "git://github.com/KhronosGroup/Vulkan-Loader.git;branch=main \

sed -i 's\git://github.com/KhronosGroup/Vulkan-Loader.git\git://github.com/KhronosGroup/Vulkan-Loader.git;branch=main\g' ../layers/poky/meta/recipes-graphics/vulkan/vulkan-loader_1.2.170.0.bb

# Extras
# ======

#/home/yoctosdk/karo-bsp/layers/poky/meta/recipes-support/libpcre/libpcre_8.44.bb
sed -i 's\https://ftp.pcre.org/pub/pcre/pcre-${PV}.tar.bz2\https://sourceforge.net/projects/pcre/files/pcre/8.44/pcre-8.44.tar.bz2\g' ../layers/poky/meta/recipes-support/libpcre/libpcre_8.44.bb

#/home/yoctosdk/karo-bsp/layers/poky/meta/recipes-core/expat/expat_2.2.10.bb
sed -i 's\${SOURCEFORGE_MIRROR}/expat/expat-${PV}.tar.bz2\https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.bz2\g' ../layers/poky/meta/recipes-core/expat/expat_2.2.10.bb

#/home/yoctosdk/karo-bsp/layers/poky/meta/recipes-core/netbase/netbase_6.2.bb
sed -i 's\${DEBIAN_MIRROR}/main/n/${BPN}/${BPN}_${PV}.tar.xz\https://old-releases.ubuntu.com/ubuntu/pool/main/n/netbase/netbase_6.2.tar.xz\g' ../layers/poky/meta/recipes-core/netbase/netbase_6.2.bb


