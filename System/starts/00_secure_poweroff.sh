#!/bin/sh

LOCKFILE="/tmp/battery_daemon.lock"

BATT_CAPACITY="/sys/class/power_supply/axp2202-battery/capacity"
BATT_STATUS="/sys/class/power_supply/axp2202-battery/status"
LED_PATH="/sys/class/led_anim"
POWEROFF_BIN="/mnt/SDCARD/Apps/poweroff/poweroff"

mkdir /tmp/sbin
cp -f "$POWEROFF_BIN" /tmp/sbin/poweroff
chmod +x /tmp/sbin/poweroff
export PATH="/tmp/sbin:${PATH}"


if [ -e "$LOCKFILE" ]; then
    echo "El script ya está en ejecución."
    exit 1
fi
trap 'rm -f "$LOCKFILE"' EXIT
touch "$LOCKFILE"

turn_on_leds() {
    echo -n 1 > "$LED_PATH/enable"
	echo 5 > /sys/class/leds/sunxi_led0r/brightness
	echo 5 > /sys/class/leds/sunxi_led0g/brightness
	echo 5 > /sys/class/leds/sunxi_led0b/brightness
    echo "FF0000" > "$LED_PATH/effect_rgb_hex_f1"
    echo "30000" > "$LED_PATH/effect_cycles_f1"
    echo "2000" > "$LED_PATH/effect_duration_f1"
    echo "6" > "$LED_PATH/effect_f1"
    echo "FF0000" > "$LED_PATH/effect_rgb_hex_f2"
    echo "30000" > "$LED_PATH/effect_cycles_f2"
    echo "2000" > "$LED_PATH/effect_duration_f2"
    echo "6" > "$LED_PATH/effect_f2"
	echo "FF0000" > "$LED_PATH/effect_rgb_hex_m"
    echo "30000" > "$LED_PATH/effect_cycles_m"
    echo "2000" > "$LED_PATH/effect_duration_m"
    echo "6" > "$LED_PATH/effect_m"
}

custom_poweroff() {
    cp -f /mnt/SDCARD/Apps/poweroff/poweroff.png /tmp/poweroff.png
	cp -f /mnt/SDCARD/trimui/bin/show /tmp/show
	chmod +x /tmp/show
    set -m
    /tmp/sbin/poweroff
}

(
    while true; do
        if [ "$(cat "$BATT_STATUS")" = "Charging" ]; then
            sleep 60
            continue
        fi

        BATTERY_LEVEL=$(cat "$BATT_CAPACITY")
        echo "Custom battery low"
        if [ "$BATTERY_LEVEL" -le 1 ]; then
            custom_poweroff
            exit 0
        elif [ "$BATTERY_LEVEL" -lt 10 ]; then
            turn_on_leds
        fi

        sleep 30
    done
) &

exit 0
