#!/bin/sh
export SWAPFILE="/mnt/SDCARD/cachefile"
export MINSIZE=$((512 * 1024 * 1024))

if [ -f "${SWAPFILE}" ]; then
    SWAPSIZE=$(ls -l "${SWAPFILE}" | awk '{print $5}')
    if [ "$SWAPSIZE" -ne "$MINSIZE" ]; then
        rm "${SWAPFILE}"
    fi
fi

if [ ! -f "${SWAPFILE}" ]; then
    dd if=/dev/zero of="${SWAPFILE}" bs=1M count=512
    mkswap "${SWAPFILE}"
    sync
fi

if [ ! -f "/tmp/swapfileon" ]; then
    swapon "${SWAPFILE}"
    touch /tmp/swapfileon
    sync
fi
