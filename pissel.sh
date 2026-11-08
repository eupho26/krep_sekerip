#!/bin/bash

# repo init
repo init -u https://github.com/aobuta-prjkt/pixelos_manifest.git -b seventeen --git-lfs --depth=1
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j32

# device source
git clone https://github.com/MinamiQuartet/android_device_xiaomi_earth.git -b PixelOS-17 device/xiaomi/earth

# setup build enviroment
. build/envsetup.sh

# export
export BUILD_USERNAME=kumiko
export BUILD_HOSTNAME=kitauji_quartet
export KBUILD_BUILD_USER="kumiko" 
export KBUILD_BUILD_HOST="kitauji_quartet"

# starting build
breakfast earth userdebug
m pixelos
