#!/bin/sh

cp -f /mnt/SDCARD/Apps/reboot/reboot /tmp/reboot
cp -f /mnt/SDCARD/Apps/reboot/reboot.png /tmp/reboot.png
cp -f /mnt/SDCARD/trimui/bin/show /tmp/show
chmod +x /tmp/reboot
chmod +x /tmp/show
sync
set -m
/tmp/reboot
