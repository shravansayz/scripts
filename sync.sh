#!/bin/bash




mkdir -p cc
mkdir -p c
# Set default values for device and commandd
wget https://github.com/ccache/ccache/releases/download/v4.10/ccache-4.10-linux-x86_64.tar.xz
tar -xf ccache-4.10-linux-x86_64.tar.xz
cd ccache-4.10-linux-x86_64
#sudo make install
#ccache --version
sudo cp ccache /usr/bin/
sudo ln -sf ccache /usr/bin/gcc
sudo ln -sf ccache /usr/bin/g++
cd ..
ccache --version

export USE_CCACHE=1
sleep 1
export CCACHE_DIR=$PWD/cc
sleep 1 
ccache -s
ccache -F 0
ccache -M 0
echo $CCACHE_DIR
ccache -s


# if [ -z "$(ls -A c)" ]; then
#   echo "Folder c is empty. Skipping the rsync command.."
# else
#   # If folder c is not empty, execute the rsync command
# time ls -1 c | xargs -I {} -P 10 -n 1 rsync -au c/{} cc/
# cp -f c/ccache.conf cc
# fi




repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs




#git clean -fdX
#rm -rf frameworks/base/
rm -rf .repo/local_manifests  mkdir vendor/lineage-priv
#rm -rf device/lge/
#rm -rf kernel/lge/msm8996
mkdir -p .repo/local_manifests
cp scripts/roomservice.xml .repo/local_manifests

#source scripts/clean.sh
#repo init --git-lfs
#rm -rf external/chromium-webview/prebuilt/*
#rm -rf .repo/projects/external/chromium-webview/prebuilt/*.git
#rm -rf .repo/project-objects/LineageOS/android_external_chromium-webview_prebuilt_*.git

main() {
    # Run repo sync command and capture the output
    repo sync -c -j64 --force-sync --no-clone-bundle --no-tags 2>&1 | tee /tmp/output.txt

    # Check if there are any failing repositories
    if grep -q "Failing repos:" /tmp/output.txt ; then
        echo "Deleting failing repositories..."
        # Extract failing repositories from the error message and echo the deletion path
        while IFS= read -r line; do
            # Extract repository name and path from the error message
            repo_info=$(echo "$line" | awk -F': ' '{print $NF}')
            repo_path=$(dirname "$repo_info")
            repo_name=$(basename "$repo_info")
            # Echo the deletion path
            echo "Deleted repository: $repo_info"
            # Save the deletion path to a text file
            echo "Deleted repository: $repo_info" > deleted_repositories.txt
            # Delete the repository
            rm -rf "$repo_path/$repo_name"
        done <<< "$(cat /tmp/output.txt | awk '/Failing repos:/ {flag=1; next} /Try/ {flag=0} flag')"

        # Re-sync all repositories after deletion
        echo "Re-syncing all repositories..."
        repo sync -c -j64 --force-sync --no-clone-bundle --no-tags
    else
        echo "All repositories synchronized successfully."
    fi
}

main $*



#source scripts/signed.sh
#source scripts/extras.sh
#source scripts/fixes.sh
chmod +x scripts/generate_certs.sh
# source scripts/generate_certs.sh
# export USE_CCACHE=1
source build/envsetup.sh
# repopick -f 390841
# repopick -f 390845
# repopick -f 390846
# repopick -f 390847
# repopick -f 390848
# repopick -f 393931
# cd device/lineage/sepolicy
# git fetch https://github.com/xc112lg/android_device_lineage_sepolicy.git patch-1
# git cherry-pick 936989aab95e9f7ae6bb3a1d95f18c4de98eb194
# cd ../../../
rm -rf ~/.android-certs
subject='/C=PH/ST=Philippines/L=Manila/O=RexC/OU=RexC/CN=Rexc/emailAddress=sksayz@gmail.com'
mkdir ~/.android-certs

for x in releasekey platform shared media networkstack testkey cyngn-priv-app bluetooth sdk_sandbox verifiedboot; do \
 yes "" |   ./development/tools/make_key ~/.android-certs/$x "$subject"; \
done

mkdir vendor/extra
mkdir vendor/lineage-priv
cp -r ~/.android-certs vendor/extra/keys

cp -r ~/.android-certs vendor/lineage-priv/keys
echo "PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/releasekey" > vendor/lineage-priv/keys/keys.mk
cat << 'EOF' >  vendor/lineage-priv/keys/BUILD.bazel
filegroup(
    name = "android_certificate_directory",
    srcs = glob([
        "*.pk8",
        "*.pem",
    ]),
    visibility = ["//visibility:public"],
)
EOF

#sed -i '/include $(LOCAL_PATH)\/vendor_prop.mk/a -include vendor/lineage-priv/keys/keys.mk' device/lge/msm8996-common/msm8996.mk


lunch lineage_RMX1901-ap1a-eng
m installclean
m bacon



















    
#    m target-files-package otatools

# croot 

# # Sign the target files and APKs
# sign_target_files_apks -o -d ~/.android-certs \
#     --extra_apks AdServicesApk.apk=$HOME/.android-certs/releasekey \
#     --extra_apks HalfSheetUX.apk=$HOME/.android-certs/releasekey \
#     --extra_apks OsuLogin.apk=$HOME/.android-certs/releasekey \
#     --extra_apks SafetyCenterResources.apk=$HOME/.android-certs/releasekey \
#     --extra_apks ServiceConnectivityResources.apk=$HOME/.android-certs/releasekey \
#     --extra_apks ServiceUwbResources.apk=$HOME/.android-certs/releasekey \
#     --extra_apks ServiceWifiResources.apk=$HOME/.android-certs/releasekey \
#     --extra_apks WifiDialog.apk=$HOME/.android-certs/releasekey \
#     --extra_apks com.android.adbd.apex=$HOME/.android-certs/com.android.adbd \
#     --extra_apks com.android.adservices.apex=$HOME/.android-certs/com.android.adservices \
#     --extra_apks com.android.adservices.api.apex=$HOME/.android-certs/com.android.adservices.api \
#     --extra_apks com.android.appsearch.apex=$HOME/.android-certs/com.android.appsearch \
#     --extra_apks com.android.art.apex=$HOME/.android-certs/com.android.art \
#     --extra_apks com.android.bluetooth.apex=$HOME/.android-certs/com.android.bluetooth \
#     --extra_apks com.android.btservices.apex=$HOME/.android-certs/com.android.btservices \
#     --extra_apks com.android.cellbroadcast.apex=$HOME/.android-certs/com.android.cellbroadcast \
#     --extra_apks com.android.compos.apex=$HOME/.android-certs/com.android.compos \
#     --extra_apks com.android.configinfrastructure.apex=$HOME/.android-certs/com.android.configinfrastructure \
#     --extra_apks com.android.connectivity.resources.apex=$HOME/.android-certs/com.android.connectivity.resources \
#     --extra_apks com.android.conscrypt.apex=$HOME/.android-certs/com.android.conscrypt \
#     --extra_apks com.android.devicelock.apex=$HOME/.android-certs/com.android.devicelock \
#     --extra_apks com.android.extservices.apex=$HOME/.android-certs/com.android.extservices \
#     --extra_apks com.android.graphics.pdf.apex=$HOME/.android-certs/com.android.graphics.pdf \
#     --extra_apks com.android.hardware.biometrics.face.virtual.apex=$HOME/.android-certs/com.android.hardware.biometrics.face.virtual \
#     --extra_apks com.android.hardware.biometrics.fingerprint.virtual.apex=$HOME/.android-certs/com.android.hardware.biometrics.fingerprint.virtual \
#     --extra_apks com.android.hardware.boot.apex=$HOME/.android-certs/com.android.hardware.boot \
#     --extra_apks com.android.hardware.cas.apex=$HOME/.android-certs/com.android.hardware.cas \
#     --extra_apks com.android.hardware.wifi.apex=$HOME/.android-certs/com.android.hardware.wifi \
#     --extra_apks com.android.healthfitness.apex=$HOME/.android-certs/com.android.healthfitness \
#     --extra_apks com.android.hotspot2.osulogin.apex=$HOME/.android-certs/com.android.hotspot2.osulogin \
#     --extra_apks com.android.i18n.apex=$HOME/.android-certs/com.android.i18n \
#     --extra_apks com.android.ipsec.apex=$HOME/.android-certs/com.android.ipsec \
#     --extra_apks com.android.media.apex=$HOME/.android-certs/com.android.media \
#     --extra_apks com.android.media.swcodec.apex=$HOME/.android-certs/com.android.media.swcodec \
#     --extra_apks com.android.mediaprovider.apex=$HOME/.android-certs/com.android.mediaprovider \
#     --extra_apks com.android.nearby.halfsheet.apex=$HOME/.android-certs/com.android.nearby.halfsheet \
#     --extra_apks com.android.networkstack.tethering.apex=$HOME/.android-certs/com.android.networkstack.tethering \
#     --extra_apks com.android.neuralnetworks.apex=$HOME/.android-certs/com.android.neuralnetworks \
#     --extra_apks com.android.ondevicepersonalization.apex=$HOME/.android-certs/com.android.ondevicepersonalization \
#     --extra_apks com.android.os.statsd.apex=$HOME/.android-certs/com.android.os.statsd \
#     --extra_apks com.android.permission.apex=$HOME/.android-certs/com.android.permission \
#     --extra_apks com.android.resolv.apex=$HOME/.android-certs/com.android.resolv \
#     --extra_apks com.android.rkpd.apex=$HOME/.android-certs/com.android.rkpd \
#     --extra_apks com.android.runtime.apex=$HOME/.android-certs/com.android.runtime \
#     --extra_apks com.android.safetycenter.resources.apex=$HOME/.android-certs/com.android.safetycenter.resources \
#     --extra_apks com.android.scheduling.apex=$HOME/.android-certs/com.android.scheduling \
#     --extra_apks com.android.sdkext.apex=$HOME/.android-certs/com.android.sdkext \
#     --extra_apks com.android.support.apexer.apex=$HOME/.android-certs/com.android.support.apexer \
#     --extra_apks com.android.telephony.apex=$HOME/.android-certs/com.android.telephony \
#     --extra_apks com.android.telephonymodules.apex=$HOME/.android-certs/com.android.telephonymodules \
#     --extra_apks com.android.tethering.apex=$HOME/.android-certs/com.android.tethering \
#     --extra_apks com.android.tzdata.apex=$HOME/.android-certs/com.android.tzdata \
#     --extra_apks com.android.uwb.apex=$HOME/.android-certs/com.android.uwb \
#     --extra_apks com.android.uwb.resources.apex=$HOME/.android-certs/com.android.uwb.resources \
#     --extra_apks com.android.virt.apex=$HOME/.android-certs/com.android.virt \
#     --extra_apks com.android.vndk.current.apex=$HOME/.android-certs/com.android.vndk.current \
#     --extra_apks com.android.vndk.current.on_vendor.apex=$HOME/.android-certs/com.android.vndk.current.on_vendor \
#     --extra_apks com.android.wifi.apex=$HOME/.android-certs/com.android.wifi \
#     --extra_apks com.android.wifi.dialog.apex=$HOME/.android-certs/com.android.wifi.dialog \
#     --extra_apks com.android.wifi.resources.apex=$HOME/.android-certs/com.android.wifi.resources \
#     --extra_apks com.google.pixel.camera.hal.apex=$HOME/.android-certs/com.google.pixel.camera.hal \
#     --extra_apks com.google.pixel.vibrator.hal.apex=$HOME/.android-certs/com.google.pixel.vibrator.hal \
#     --extra_apex_payload_key com.android.adbd.apex=$HOME/.android-certs/com.android.adbd.pem \
#     --extra_apex_payload_key com.android.adservices.apex=$HOME/.android-certs/com.android.adservices.pem \
#     --extra_apex_payload_key com.android.adservices.api.apex=$HOME/.android-certs/com.android.adservices.api.pem \
#     --extra_apex_payload_key com.android.appsearch.apex=$HOME/.android-certs/com.android.appsearch.pem \
#     --extra_apex_payload_key com.android.art.apex=$HOME/.android-certs/com.android.art.pem \
#     --extra_apex_payload_key com.android.bluetooth.apex=$HOME/.android-certs/com.android.bluetooth.pem \
#     --extra_apex_payload_key com.android.btservices.apex=$HOME/.android-certs/com.android.btservices.pem \
#     --extra_apex_payload_key com.android.cellbroadcast.apex=$HOME/.android-certs/com.android.cellbroadcast.pem \
#     --extra_apex_payload_key com.android.compos.apex=$HOME/.android-certs/com.android.compos.pem \
#     --extra_apex_payload_key com.android.configinfrastructure.apex=$HOME/.android-certs/com.android.configinfrastructure.pem \
#     --extra_apex_payload_key com.android.connectivity.resources.apex=$HOME/.android-certs/com.android.connectivity.resources.pem \
#     --extra_apex_payload_key com.android.conscrypt.apex=$HOME/.android-certs/com.android.conscrypt.pem \
#     --extra_apex_payload_key com.android.devicelock.apex=$HOME/.android-certs/com.android.devicelock.pem \
#     --extra_apex_payload_key com.android.extservices.apex=$HOME/.android-certs/com.android.extservices.pem \
#     --extra_apex_payload_key com.android.graphics.pdf.apex=$HOME/.android-certs/com.android.graphics.pdf.pem \
#     --extra_apex_payload_key com.android.hardware.biometrics.face.virtual.apex=$HOME/.android-certs/com.android.hardware.biometrics.face.virtual.pem \
#     --extra_apex_payload_key com.android.hardware.biometrics.fingerprint.virtual.apex=$HOME/.android-certs/com.android.hardware.biometrics.fingerprint.virtual.pem \
#     --extra_apex_payload_key com.android.hardware.boot.apex=$HOME/.android-certs/com.android.hardware.boot.pem \
#     --extra_apex_payload_key com.android.hardware.cas.apex=$HOME/.android-certs/com.android.hardware.cas.pem \
#     --extra_apex_payload_key com.android.hardware.wifi.apex=$HOME/.android-certs/com.android.hardware.wifi.pem \
#     --extra_apex_payload_key com.android.healthfitness.apex=$HOME/.android-certs/com.android.healthfitness.pem \
#     --extra_apex_payload_key com.android.hotspot2.osulogin.apex=$HOME/.android-certs/com.android.hotspot2.osulogin.pem \
#     --extra_apex_payload_key com.android.i18n.apex=$HOME/.android-certs/com.android.i18n.pem \
#     --extra_apex_payload_key com.android.ipsec.apex=$HOME/.android-certs/com.android.ipsec.pem \
#     --extra_apex_payload_key com.android.media.apex=$HOME/.android-certs/com.android.media.pem \
#     --extra_apex_payload_key com.android.media.swcodec.apex=$HOME/.android-certs/com.android.media.swcodec.pem \
#     --extra_apex_payload_key com.android.mediaprovider.apex=$HOME/.android-certs/com.android.mediaprovider.pem \
#     --extra_apex_payload_key com.android.nearby.halfsheet.apex=$HOME/.android-certs/com.android.nearby.halfsheet.pem \
#     --extra_apex_payload_key com.android.networkstack.tethering.apex=$HOME/.android-certs/com.android.networkstack.tethering.pem \
#     --extra_apex_payload_key com.android.neuralnetworks.apex=$HOME/.android-certs/com.android.neuralnetworks.pem \
#     --extra_apex_payload_key com.android.ondevicepersonalization.apex=$HOME/.android-certs/com.android.ondevicepersonalization.pem \
#     --extra_apex_payload_key com.android.os.statsd.apex=$HOME/.android-certs/com.android.os.statsd.pem \
#     --extra_apex_payload_key com.android.permission.apex=$HOME/.android-certs/com.android.permission.pem \
#     --extra_apex_payload_key com.android.resolv.apex=$HOME/.android-certs/com.android.resolv.pem \
#     --extra_apex_payload_key com.android.rkpd.apex=$HOME/.android-certs/com.android.rkpd.pem \
#     --extra_apex_payload_key com.android.runtime.apex=$HOME/.android-certs/com.android.runtime.pem \
#     --extra_apex_payload_key com.android.safetycenter.resources.apex=$HOME/.android-certs/com.android.safetycenter.resources.pem \
#     --extra_apex_payload_key com.android.scheduling.apex=$HOME/.android-certs/com.android.scheduling.pem \
#     --extra_apex_payload_key com.android.sdkext.apex=$HOME/.android-certs/com.android.sdkext.pem \
#     --extra_apex_payload_key com.android.support.apexer.apex=$HOME/.android-certs/com.android.support.apexer.pem \
#     --extra_apex_payload_key com.android.telephony.apex=$HOME/.android-certs/com.android.telephony.pem \
#     --extra_apex_payload_key com.android.telephonymodules.apex=$HOME/.android-certs/com.android.telephonymodules.pem \
#     --extra_apex_payload_key com.android.tethering.apex=$HOME/.android-certs/com.android.tethering.pem \
#     --extra_apex_payload_key com.android.tzdata.apex=$HOME/.android-certs/com.android.tzdata.pem \
#     --extra_apex_payload_key com.android.uwb.apex=$HOME/.android-certs/com.android.uwb.pem \
#     --extra_apex_payload_key com.android.uwb.resources.apex=$HOME/.android-certs/com.android.uwb.resources.pem \
#     --extra_apex_payload_key com.android.virt.apex=$HOME/.android-certs/com.android.virt.pem \
#     --extra_apex_payload_key com.android.vndk.current.apex=$HOME/.android-certs/com.android.vndk.current.pem \
#     --extra_apex_payload_key com.android.vndk.current.on_vendor.apex=$HOME/.android-certs/com.android.vndk.current.on_vendor.pem \
#     --extra_apex_payload_key com.android.wifi.apex=$HOME/.android-certs/com.android.wifi.pem \
#     --extra_apex_payload_key com.android.wifi.dialog.apex=$HOME/.android-certs/com.android.wifi.dialog.pem \
#     --extra_apex_payload_key com.android.wifi.resources.apex=$HOME/.android-certs/com.android.wifi.resources.pem \
#     --extra_apex_payload_key com.google.pixel.camera.hal.apex=$HOME/.android-certs/com.google.pixel.camera.hal.pem \
#     --extra_apex_payload_key com.google.pixel.vibrator.hal.apex=$HOME/.android-certs/com.google.pixel.vibrator.hal.pem \
#     --extra_apex_payload_key com.qorvo.uwb.apex=$HOME/.android-certs/com.qorvo.uwb.pem \
#     $OUT/obj/PACKAGING/target_files_intermediates/*-target_files*.zip \
#     signed-target_files.zip

# # Create OTA update package from signed target files
# ota_from_target_files -k ~/.android-certs/releasekey \
#     --block --backup=true \
#     signed-target_files.zip \
#     signed-ota_update.zip


