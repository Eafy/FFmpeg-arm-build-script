#!/bin/sh

FF_VERSION="3.4.2"
FF_SOURCE=`pwd`/"ffmpeg-$FF_VERSION"
FF_PREFIX=`pwd`/FFmpeg-arm
#X264_PATH=`pwd`/x264-arm
ARM_GCC=arm-buildroot-linux-gnueabi

mkdir -p $FF_PREFIX && rm $FF_PREFIX/* -rf
cd $FF_SOURCE

echo "ffmpeg_Sources:$FF_SOURCE"
echo "ffmpeg_Prefix:$FF_PREFIX"


CONFIGURE_FLAGS="--disable-encoders --disable-decoders --disable-demuxers --disable-muxers --disable-parsers --disable-filters --enable-avfilter --enable-filter=anull --enable-encoder=h264,aac --enable-decoder=h264,aac --enable-muxer=h264,aac,flv,mp4 --enable-demuxer=h264,aac*,flv --enable-parser=h264,aac"

CONFIGURE_CFLAGS=""
CONFIGURE_LDFLAGS=""

if [ "$X264_PATH" ]
then
    CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-gpl --enable-libx264"
    CONFIGURE_CFLAGS="-I$CONFIGURE_CFLAGS$X264_PATH/include"
    CONFIGURE_LDFLAGS="-L$CONFIGURE_LDFLAGS$X264_PATH/lib"
    echo "x264_cflags:$CONFIGURE_CFLAGS"
    echo "x264_ldflags:$CONFIGURE_LDFLAGS"
fi

./configure \
--cc=$ARM_GCC-gcc \
--prefix=$FF_PREFIX \
--cross-prefix=$ARM_GCC- \
--enable-cross-compile \
--target-os=linux \
--arch=arm \
--enable-static \
--enable-shared \
--disable-debug \
--disable-programs \
--disable-ffplay \
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
