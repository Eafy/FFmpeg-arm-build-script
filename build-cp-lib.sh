#!/bin/sh
#http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20171212-2245.tar.bz2

rm -rf ./FFmpeg-arm/share
rm -rf ./FFmpeg-arm/lib/pkgconfig
rm -rf ./x264-arm/lib/pkgconfig
cp -rf ./FFmpeg-arm ../Build/lib/
cp -rf ./x264-arm ../Build/lib/
rm -rf ../Build/lib/ffmpeg
rm -rf ../Build/lib/x264
mv ../Build/lib/FFmpeg-arm ../Build/lib/ffmpeg
mv ../Build/lib/x264-arm ../Build/lib/x264
cp -rf ../Build/lib/x264 /mnt/share
cp -rf ../Build/lib/ffmpeg /mnt/share
