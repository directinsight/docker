#!/bin/bash

# fix FILE 'SEARCH' 'REPLACEMENT' - makes the change only if it hasn't been made already
fix() {
    grep -qF "$3" "$1" || sed -i "s|$2|$3|g" "$1"
}

# There is no sstate cache for the hardknott branch on Karo's sstate mirror; remove it from local.conf
# (already safe to repeat, since a second run finds nothing to delete)
sed -i '/sstate.karo-electronics.de/d' conf/local.conf

# Fix /etc/fstab for TX6:
fix ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab \
    'PARTLABEL=rootfs' 'PARTUUID=0cc66cc0-02'
fix ../layers/meta-karo-distro/recipes-core/base-files/base-files/fstab \
    'PARTLABEL=boot' 'PARTUUID=0cc66cc0-01'

# Some GitHub Repos have switched from master to main branch:
fix ../layers/poky/meta/recipes-graphics/spir/spirv-headers_1.5.4.bb \
    'git://github.com/KhronosGroup/SPIRV-Headers;protocol=https' \
    'git://github.com/KhronosGroup/SPIRV-Headers;protocol=https;branch=main'
fix ../layers/poky/meta/recipes-graphics/spir/spirv-tools_2020.7.bb \
    'git://github.com/KhronosGroup/SPIRV-Tools.git' \
    'git://github.com/KhronosGroup/SPIRV-Tools.git;branch=main'
fix ../layers/poky/meta/recipes-graphics/glslang/glslang_11.2.0.bb \
    'git://github.com/KhronosGroup/glslang.git;protocol=https' \
    'git://github.com/KhronosGroup/glslang.git;protocol=https;branch=main'
fix ../layers/poky/meta/recipes-graphics/vulkan/vulkan-loader_1.2.170.0.bb \
    'git://github.com/KhronosGroup/Vulkan-Loader.git' \
    'git://github.com/KhronosGroup/Vulkan-Loader.git;branch=main'

# Some other repos have changed location
fix ../layers/poky/meta/recipes-support/libpcre/libpcre_8.44.bb \
    'https://ftp.pcre.org/pub/pcre/pcre-${PV}.tar.bz2' \
    'https://sourceforge.net/projects/pcre/files/pcre/8.44/pcre-8.44.tar.bz2'
fix ../layers/poky/meta/recipes-core/expat/expat_2.2.10.bb \
    '${SOURCEFORGE_MIRROR}/expat/expat-${PV}.tar.bz2' \
    'https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.bz2'
fix ../layers/poky/meta/recipes-core/netbase/netbase_6.2.bb \
    '${DEBIAN_MIRROR}/main/n/${BPN}/${BPN}_${PV}.tar.xz' \
    'https://old-releases.ubuntu.com/ubuntu/pool/main/n/netbase/netbase_6.2.tar.xz'
