#!/bin/sh

touch /tmp/poweroff_flag
cp -f /mnt/SDCARD/Apps/poweroff/poweroff /tmp/poweroff
cp -f /mnt/SDCARD/Apps/poweroff/poweroff.png /tmp/poweroff.png
cp -f /mnt/SDCARD/trimui/bin/show /tmp/show
chmod +x /tmp/poweroff
chmod +x /tmp/show
sync
set -m
/tmp/poweroff
