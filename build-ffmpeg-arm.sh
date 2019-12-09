#!/bin/sh

FF_VERSION="3.4.2"
FF_SOURCE=`pwd`/"ffmpeg-$FF_VERSION"
FF_PREFIX=`pwd`/FFmpeg-arm
ARM_GCC=arm-buildroot-linux-gnueabi

mkdir -p $FF_PREFIX && rm $FF_PREFIX/* -rf
cd $FF_SOURCE

echo "ffmpeg_Sources:$FF_SOURCE"
echo "ffmpeg_Prefix:$FF_PREFIX"


CONFIGURE_FLAGS="--disable-encoders --disable-decoders --disable-demuxers --disable-muxers --disable-parsers --disable-filters --enable-avfilter --disable-indevs --disable-outdevs --disable-postproc --enable-filter=anull --enable-encoder=h264,aac --enable-decoder=h264,aac --enable-muxer=h264,aac,flv --enable-demuxer=h264,aac,flv --enable-parser=h264,aac --disable-protocol=rtp --disable-protocol=sctp --disable-protocol=ftp --disable-protocol=hls --disable-protocol=concat --disable-protocol=icecast --disable-bsfs --enable-bsf=aac_adtstoasc --enable-bsf=h264_mp4toannexb --enable-bsf=null --enable-bsf=noise"

CONFIGURE_CFLAGS=""
CONFIGURE_LDFLAGS=""

./configure \
--cc=$ARM_GCC-gcc \
--prefix=$FF_PREFIX \
--cross-prefix=$ARM_GCC- \
--enable-cross-compile \
--target-os=linux \
--arch=arm \
--disable-static \
--enable-shared \
--disable-debug \
--disable-programs \
--disable-ffplay \
--disable-ffmpeg \
--disable-ffserver \
--disable-ffprobe \
--disable-doc \
--enable-pic \
--enable-gpl \
--enable-nonfree \
--disable-armv5te \
--disable-armv6 \
--disable-armv6t2 \
--disable-stripping \
--disable-x86asm \
$CONFIGURE_FLAGS \
--extra-cflags=$CONFIGURE_CFLAGS \
--extra-ldflags=$CONFIGURE_LDFLAGS

make && make install
exit 0
