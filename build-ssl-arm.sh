#!/bin/sh
#https://www.openssl.org/source/openssl-1.1.0k.tar.gz

SSL_PATH=`pwd`/openssl-1.1.0k
SSL_PREFIX=${SSL_PATH}-arm
ARM_GCC=arm-buildroot-linux-gnueabi

echo "SSL_PATH:$SSL_PATH"
echo "SSL_PREFIX:$SSL_PREFIX"

mkdir -p $SSL_PREFIX && rm $SSL_PREFIX/* -rf
cd $SSL_PATH

CC=${ARM_GCC}-gcc \
./Configure \
linux-generic32 \
shared \
no-asm \
--prefix=$SSL_PREFIX \
--openssldir=$SSL_PATH/ssl

make && make install
exit 0
