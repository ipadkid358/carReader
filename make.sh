#!/bin/bash

xcodebuild clean build CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" -sdk "$(xcrun --sdk iphoneos --show-sdk-path)" -arch arm64 -arch armv7 || {
    exit 1
}

cd build || {
    echo "Failed to change to build directory"
    exit 1
}

test "$1" = "ipa" && {
    kPayloadDir="Payload"
    kIPAName="com.ipadkid.carReader_0.0.1.ipa"

    mkdir "$kPayloadDir"
    mv Release-iphoneos/carReader.app "$kPayloadDir"
    zip -r "$kIPAName" "$kPayloadDir"
    mv "$kIPAName" ..
    echo "Created IPA at "$kIPAName""
}

test "$1" = "deb" && {
    kPayloadDir="Payload"
    kDebName="com.ipadkid.carReader_0.0.1_iphoneos-arm.deb"

    mkdir -p "$kPayloadDir"/DEBIAN
    mkdir "$kPayloadDir"/Applications

    mv Release-iphoneos/carReader.app "$kPayloadDir"/Applications
    cp ../control "$kPayloadDir"/DEBIAN
    ldid -S../ent.plist -Icom.ipadkid.carReader "$kPayloadDir"/Applications/carReader.app/carReader
    dpkg-deb -Zlzma -b "$kPayloadDir" "$kDebName"
    mv "$kDebName" ..
    echo "Created deb at "$kDebName""
}

cd ..
rm -r build
