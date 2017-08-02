#!/usr/bin/env bash

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
require_env "XPREFIX" "${XPREFIX}"
require_env "TARGET" "${TARGET}"

rm -rf binutils-build
mkdir binutils-build
cd binutils-build

../configure \
    --target=$TARGET \
    --prefix=$XPREFIX \
    --with-sysroot=${SYSROOT} \
    --disable-nls \
    --disable-werror && make && make install
