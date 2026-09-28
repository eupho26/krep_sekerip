#!/bin/bash

# repo init
repo init --depth=1 -u https://github.com/Lunaris-AOSP/android.git -b 16.2 --git-lfs

# sync + remove dirty
/opt/crave/resync.sh

# device source
git clone https://github.com/MinamiQuartet/android_device_xiaomi_earth.git -b Lunaris-16.2 device/xiaomi/earth

# custom source
rm -rf vendor/lineage
git clone https://github.com/eupho26/vendor_lunaris.git -b 16.2 vendor/lineage --depth=1

export BUILD_USERNAME=eupho
export BUILD_HOSTNAME=minami

# build start
. build/envsetup.sh
lunch lineage_earth-bp4a-userdebug
mka bacon

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/earth/*2026*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh && ./upload.sh out/target/product/earth/*2026*.zip
    echo "Upload & clean up Done!"
else
    echo "No zip found in out/ dir!" 
    exit 1
fi
