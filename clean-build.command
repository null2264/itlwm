#!/bin/bash
# Sauce: https://github.com/OpenIntelWireless/itlwm/issues/353#issuecomment-727190996
# @racka98

[ -d "MacKernelSDK" ] && "MacKernelSDK is exists! skipping..." || git clone https://github.com/acidanthera/MacKernelSDK.git

# remove all local changes
git reset --hard HEAD
rm -rf build

# pull latest code
git pull

# remove generated firmware
rm include/FwBinary.cpp

# remove firmware for other wifi cards - DELETE OR CHANGE TO YOUR CARD
find itlwm/firmware/ -type f ! -name 'iwm-8000C*' -delete

# generate firmware
xcodebuild -project itlwm.xcodeproj -target fw_gen -configuration Release -sdk macosx

# build the kexts
## itlwm.kext
# xcodebuild -project itlwm.xcodeproj -target itlwm -configuration Release -sdk macosx

## AirportItlwm.kext - Monterey
xcodebuild -project itlwm.xcodeproj -target AirportItlwm-Monterey -configuration Release -sdk macosx

## AirportItlwm.kext - Ventura
xcodebuild -project itlwm.xcodeproj -target AirportItlwm-Ventura -configuration Release -sdk macosx

# Location of Kexts
echo "You kexts are in build/Release!!"
echo " "
