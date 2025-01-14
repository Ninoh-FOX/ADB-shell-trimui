#!/bin/sh

mount -o bind /mnt/SDCARD/Apps/adb_shell/profile /etc/profile
/usr/trimui/bin/usb_device.sh
/bin/setusbconfig adb &
