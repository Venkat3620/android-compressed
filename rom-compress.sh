#!/bin/bash

ROMNAME=lineage-16.0
LINK=https://github.com/LineageOS/android
BRANCH=lineage-16.0


echo -e "# Installing necessary packages..."
sudo apt install bc pxz wput
echo -e "# Installed"

mkdir $ROMNAME && cd $ROMNAME

echo -e "# Installing repo..."
repo init -u $LINK -b $BRANCH --depth 1 -q
echo -e "# Installed"

echo -e "# Syncing..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
echo -e "# Synced"

echo -e "# Starting Compression..."
export XZ_OPT=-9e
tar -I pxz -cf - * | split -b 4500M - $ROMNAME.tar.xz.
echo -e "# Compressed"

echo -e "# Done"
