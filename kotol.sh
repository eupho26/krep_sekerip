#!/bin/bash

# repo init
# repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 17 -g default,-mips,-darwin,-notdefault

# Crave Sync + remove dirty
# /opt/crave/resync.sh
# repo sync -c --force-sync --force-remove-dirty --no-tags --no-clone-bundle # For fixing sync error

# device source
# rm -rf device/xiaomi/earth
# git clone https://github.com/MinamiQuartet/android_device_xiaomi_earth.git -b Infinity-17 device/xiaomi/earth

# patch build/soong
# cd build/soong
# curl -LSs "https://github.com/sweet-bullet/build_soong_evo/commit/47b4d25fbb8e1713f1304dc78f357a0d858946a2.patch" | git am
# cd ../..

# patching vendor/infinity
# cd vendor/infinity
# curl -LSs "https://github.com/eupho26/vendor_infinity/commit/ff6fbc375f4d01aa6c8e82225f9a982130a54213.patch" | git am
# cd ../..

export BUILD_USERNAME=eupho
export BUILD_HOSTNAME=minami

# build start
. build/envsetup.sh
lunch infinity_earth-userdebug
make installclean
mka bacon

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/earth/*2026*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh ; ./upload.sh out/target/product/earth/*2026*.zip
    echo "Upload Done!"
else
    echo "No zip found!"
    exit 1
fi
