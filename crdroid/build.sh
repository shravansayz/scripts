#!/bin/bash

source build/envsetup.sh

TARGET_BUILD_PACKAGES=(1 2 3)

for i in ${TARGET_BUILD_PACKAGES[@]}; do
    echo "Building package: $i"
    sed -i 's/TARGET_BUILD_PACKAGE := .*/TARGET_BUILD_PACKAGE := '$i'/gm;t' device/xiaomi/sweet2/lineage_sweet2.mk
    cat device/xiaomi/sweet2/lineage_sweet2.mk | grep "TARGET_BUILD_PACKAGE := "
    brunch sweet2 user
done
