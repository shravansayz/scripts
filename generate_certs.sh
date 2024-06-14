#!/bin/bash

# Define the subject for the initial certificates
subject='/C=PH/ST=Philippines/L=Manila/O=RexC/OU=RexC/CN=Rexc/emailAddress=dtiven13@gmail.com'

# Create the directory for the Android certificates
mkdir -p ~/.android-certs

# Generate initial certificates
for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do
yes "" |    ./development/tools/make_key ~/.android-certs/$cert "$subject"
done

# Copy the make_key tool to the certificates directory
cp ./development/tools/make_key ~/.android-certs/

# Modify the key size in the make_key tool from 2048 to 4096
sed -i 's|2048|4096|g' ~/.android-certs/make_key

# Generate APEX keys and convert to PEM format
for apex in com.android.adbd com.android.adservices com.android.adservices.api com.android.appsearch com.android.art com.android.bluetooth com.android.btservices com.android.cellbroadcast com.android.compos com.android.configinfrastructure com.android.connectivity.resources com.android.conscrypt com.android.devicelock com.android.extservices com.android.graphics.pdf com.android.hardware.biometrics.face.virtual com.android.hardware.biometrics.fingerprint.virtual com.android.hardware.boot com.android.hardware.cas com.android.hardware.wifi com.android.healthfitness com.android.hotspot2.osulogin com.android.i18n com.android.ipsec com.android.media com.android.media.swcodec com.android.mediaprovider com.android.nearby.halfsheet com.android.networkstack.tethering com.android.neuralnetworks com.android.ondevicepersonalization com.android.os.statsd com.android.permission com.android.resolv com.android.rkpd com.android.runtime com.android.safetycenter.resources com.android.scheduling com.android.sdkext com.android.support.apexer com.android.telephony com.android.telephonymodules com.android.tethering com.android.tzdata com.android.uwb com.android.uwb.resources com.android.virt com.android.vndk.current com.android.vndk.current.on_vendor com.android.wifi com.android.wifi.dialog com.android.wifi.resources com.google.pixel.camera.hal com.google.pixel.vibrator.hal com.qorvo.uwb; do
    subject='/C=PH/ST=Philippines/L=Manila/O=RexC/OU=RexC/CN=Rexc/emailAddress=dtiven13@gmail.com'
yes "" |    ~/.android-certs/make_key ~/.android-certs/$apex "$subject"
    openssl pkcs8 -in ~/.android-certs/$apex.pk8 -inform DER -nocrypt -out ~/.android-certs/$apex.pem
done
