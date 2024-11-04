#!/bin/sh
progdir=$(dirname "$0")
cd $progdir
mount -o bind ./profile /etc/profile
/usr/trimui/bin/usb_device.sh
/bin/setusbconfig adb &
