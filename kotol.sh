#!/bin/bash

# repo init
git config --global url."https://x-access-token:${GUTHIB}@github.com/".insteadOf "https://github.com/"
repo init -u https://github.com/ShinkaiProject/shinkai_manifest.git -b heptakaideka --git-lfs --depth=1 

# Crave Sync + remove dirty
/opt/crave/resync.sh
repo sync -c --force-sync --force-remove-dirty --no-tags --no-clone-bundle # For fixing sync error

# device source
git clone https://github.com/MinamiQuartet/android_device_xiaomi_earth.git -b Shinkai-17 device/xiaomi/earth

# patch build/soong
cd build/soong
curl -LSs "https://github.com/sweet-bullet/build_soong_evo/commit/47b4d25fbb8e1713f1304dc78f357a0d858946a2.patch" | git am
cd ../..

export BUILD_USERNAME=eupho
export BUILD_HOSTNAME=minami

# build start
. build/envsetup.sh
breakfast earth userdebug
mka shinkai

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
