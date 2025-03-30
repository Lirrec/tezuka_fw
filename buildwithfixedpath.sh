#!/bin/bash


BUILDROOT_VERSION=2024.11.1


if [[ ! -d buildroot-$BUILDROOT_VERSION ]]
then
	echo ">>> Downloading buildroot $BUILDROOT_VERSION"
	wget https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.gz
	tar -xf buildroot-$BUILDROOT_VERSION.tar.gz
fi



echo "Fixing spaces in path (might be necessary for WSL builds)"
ORIGINAL_PATH=${PATH}
NEW_PATH=$(echo ${PATH} | sed -e "s-:/mnt.*--")
export PATH=${NEW_PATH}

echo "sourcing sourceme.first"
. sourceme.first

pushd buildroot-2024.11.1
	make libre_maiasdr_defconfig
	make
popd

echo ">>> Restoring Path variable"
PATH=${ORIGINAL_PATH}
export PATH=${NEW_PATH}
