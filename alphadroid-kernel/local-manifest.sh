#!/bin/bash

mkdir -p .repo/local_manifests

cat > .repo/local_manifests/local_manifest.xml <<- EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project path="device/xiaomi/sweet2" name="xiaomi-sweet2/android_device_xiaomi_sweet2" remote="github" revision="14.0/alphadroid" clone-depth="1" />
    <project path="device/xiaomi/sm6150-common" name="xiaomi-sweet2/android_device_xiaomi_sm6150-common" remote="github" revision="14.0" clone-depth="1" />
    <project path="vendor/xiaomi/sweet2" name="xiaomi-sweet2/android_vendor_xiaomi_sweet2" remote="github" revision="14.0" clone-depth="1" />
    <project path="vendor/xiaomi/sm6150-common" name="xiaomi-sweet2/android_vendor_xiaomi_sm6150-common" remote="github" revision="14.0" clone-depth="1" />
    <project path="kernel/xiaomi/sm6150" name="marat2509/kernel_xiaomi_sm6150_sleepy" remote="github" revision="sleepy-k6a-inline" clone-depth="1" />
</manifest>
EOF
