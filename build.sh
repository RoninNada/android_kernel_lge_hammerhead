#!/bin/bash

###################### CONFIG ######################

# root directory of Kernel git repo (default is this script's location)
RDIR=$(pwd)

# directory containing cross-compile arm toolchain
TOOLCHAIN=/home/zero/toolchains/arm-linux-androideabi-4.9

############## SCARY NO-TOUCHY STUFF ###############

export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-

if ! [ -f $RDIR"/arch/arm/configs/zero_hammerhead_defconfig" ] ; then
	echo "zero_hammerhead_defconfig defconfig not found in arm64 configs!"
	exit -1
fi

BUILD_KERNEL()
{
	echo "Creating kernel config..."
	make zero_hammerhead_defconfig
	echo "Starting build..."
	make -j$(nproc --all)
}

DO_BUILD()
{
	echo "Starting build for Hammerhead..."
	BUILD_KERNEL || {
		echo "Error!"
		exit -1
	}
}

DO_BUILD
