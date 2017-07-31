#!/usr/bin/env bash

export SYSROOT="$(readlink -f $(pwd)/../../..)"
export PREFIX="${SYSROOT}/usr"
export TARGET=i686-rpos
export PATH="${PREFIX}/bin:$PATH"

rm -rf binutils-build
mkdir binutils-build
cd binutils-build

../configure --target=$TARGET --prefix=$PREFIX  --with-sysroot=${SYSROOT} --disable-nls --disable-werror
[ $? == 0 ] && make
[ $? == 0 ] && make install
[ $? != 0 ] && exit 2
