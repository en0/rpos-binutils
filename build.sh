#!/usr/bin/env bash

#export SYSROOT="$(readlink -f $(pwd)/../../..)"
#export PREFIX="${SYSROOT}/usr"
#export TARGET=i686-rpos
#export PATH="${PREFIX}/bin:$PATH"

abort() {
    MESSAGE=$1
    EXITCODE=$2
    if [[ -z "$EXITCODE" ]]
    then
        EXITCODE=1
    fi

    printf "ERROR: %s\n" "${MESSAGE}" 1>&2
    exit $EXITCODE
}

require_env() {
    [[ -z "$2" ]] && \
        abort "\$$1 is not set. Please source the desired environment." 1
}

require_env "SYSROOT" "${SYSROOT}"
require_env "PREFIX" "${PREFIX}"
require_env "TARGET" "${TARGET}"
require_env "PATH" "${PATH}"

rm -rf binutils-build
mkdir binutils-build
cd binutils-build

../configure \
    --target=$TARGET \
    --prefix=$PREFIX \
    --with-sysroot=${SYSROOT} \
    --disable-nls \
    --disable-werror && make && make install
