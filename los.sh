#!/bin/bash

# repo init
repo init --depth=1 -u https://github.com/Lunaris-AOSP/android.git -b 16.2 --git-lfs

# lokal manifest
git clone https://github.com/MinamiQuartet/minami_manifest.git -b lineage-24.0 .repo/local_manifests

# sync + remove dirty
/opt/crave/resync.sh

export BUILD_USERNAME=eupho
export BUILD_HOSTNAME=minami

# build start
. build/envsetup.sh
lunch lineage_earth-cp2a-userdebug
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
