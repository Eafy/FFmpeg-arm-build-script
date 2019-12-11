#!/bin/sh
#http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20171212-2245.tar.bz2

X264_PATH=`pwd`/x264
X264_PREFIX=${X264_PATH}-arm
ARM_GCC=arm-buildroot-linux-gnueabi

echo "X264_PATH:$X264_PATH"
echo "X264_PREFIX:$X264_PREFIX"

mkdir -p $X264_PREFIX && rm $X264_PREFIX/* -rf
cd $X264_PATH

CC=$ARM_GCC-gcc \
./configure \
--host=$ARM_GCC \
--disable-static \
--enable-shared \
--enable-pic \
--prefix=$X264_PREFIX \
--cross-prefix=$ARM_GCC- \
--disable-asm \
--disable-cli

make && make install
exit 0
