#!/bin/sh
#https://curl.haxx.se/download.html/curl-7.66.0

CURL_PATH=`pwd`/curl-7.66.0
CURL_PREFIX=${CURL_PATH}-arm
SSL_PATH=`pwd`/openssl-1.1.0k-arm
ARM_GCC=arm-buildroot-linux-gnueabi

echo "CURL_PATH:$CURL_PATH"
echo "CURL_PREFIX:$CURL_PREFIX"

mkdir -p $CURL_PREFIX && rm $CURL_PREFIX/* -rf
cd $CURL_PATH

CPPFLAGS="-I$SSL_PATH -I$SSL_PATH/include" LDFLAGS="-L$SSL_PATH/lib" LIBS="-ldl" \
./configure \
--host=$ARM_GCC \
CC=$ARM_GCC-gcc \
CXX=$ARM_GCC-g++ \
--disable-shared \
--enable-static \
--enable-shared \
--disable-dict \
--disable-ftp \
--disable-imap \
--disable-ldap \
--disable-ldaps \
--disable-pop3 \
--disable-proxy \
--disable-rtsp \
--disable-smtp \
--disable-telnet \
--disable-tftp \
--disable-zlib \
--without-ca-bundle \
--without-gnutls \
--without-libidn \
--without-librtmp \
--without-libssh2 \
--without-nss \
--without-zlib \
--prefix=$CURL_PREFIX \
--with-ssl=$SSL_PATH

make && make install
exit 0
