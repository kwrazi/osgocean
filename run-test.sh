#!/usr/bin/env bash
#
# Kiet To
#

# ---- useful alternative to "set -e" --------------
# references:
#    https://stackoverflow.com/questions/35800082
err_report () {
    echo "$0: Error on line $1"
}
if [[ $_ == $0 ]]; then
    set -eE
    trap 'err_report $LINENO' ERR
else
    echo "WARNING: Script is being sourced."
fi
# --------------------------------------------------

[ ! -d build ] && mkdir -pv build
if [ ! -f ./build/Makefile ]; then
    pushd build
    cmake ..
    popd
fi
nice make -j$(nproc) -C build

# ---- unit under test -----------------------------
BINARY=./build/bin/oceanSim
if [ -x "${BINARY}" ]; then
    "${BINARY}" --help
    "${BINARY}" --outputImage ocean --totalFrames 10
else
    echo "executable not found."
fi
