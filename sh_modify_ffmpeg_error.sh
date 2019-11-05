#!/bin/sh

SRCROOT=`pwd`
SRC_DIR=${SRCROOT}
PATCH_PATH=${SRCROOT}

set -x
patch  -p0 -N --dry-run --silent -f $SRC_DIR/lib/ffmpeg/include/libavutil/error.h < $PATCH_PATH/patch_modify_ffmpeg_error.patch 1>/dev/null
if [ $? -eq 0 ]; then
patch -p0 -f $SRC_DIR/lib/ffmpeg/include/libavutil/error.h < $PATCH_PATH/patch_modify_ffmpeg_error.patch
fi
