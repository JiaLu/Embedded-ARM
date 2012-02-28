#!/bin/sh
led="/sys/class/leds/beaglebone::"

get_led_state () {
usr0_trigger=`cat ${led}usr0/trigger | sed -e "s/^.*\[\(.*\)\].*$/\1/"`
usr1_trigger=`cat ${led}usr1/trigger | sed -e "s/^.*\[\(.*\)\].*$/\1/"`
usr2_trigger=`cat ${led}usr2/trigger | sed -e "s/^.*\[\(.*\)\].*$/\1/"`
usr3_trigger=`cat ${led}usr3/trigger | sed -e "s/^.*\[\(.*\)\].*$/\1/"`
usr0_brightness=`cat ${led}usr0/brightness`
usr1_brightness=`cat ${led}usr1/brightness`
usr2_brightness=`cat ${led}usr2/brightness`
usr3_brightness=`cat ${led}usr3/brightness`
echo "USR0 LED state ($usr0_brightness) [$usr0_trigger]"
echo "USR1 LED state ($usr1_brightness) [$usr1_trigger]"
echo "USR2 LED state ($usr2_brightness) [$usr2_trigger]"
echo "USR3 LED state ($usr3_brightness) [$usr3_trigger]"
}

get_led_state
save0t="$usr0_trigger"
save0b="$usr0_brightness"
save1t="$usr1_trigger"
save1b="$usr1_brightness"
save2t="$usr2_trigger"
save2b="$usr2_brightness"
save3t="$usr3_trigger"
save3b="$usr3_brightness"

echo "Turning LEDs on for 3 seconds..."
echo "none" > ${led}usr0/trigger
echo "none" > ${led}usr1/trigger
echo "none" > ${led}usr2/trigger
echo "none" > ${led}usr3/trigger
echo "1" > ${led}usr0/brightness
echo "1" > ${led}usr1/brightness
echo "1" > ${led}usr2/brightness
echo "1" > ${led}usr3/brightness
get_led_state
sleep 3

echo "Turning USR0 LED off for 3 seconds..."
echo "0" > ${led}usr0/brightness
get_led_state
sleep 3

echo "Turning USR1 LED off for 3 seconds..."
echo "0" > ${led}usr1/brightness
get_led_state
sleep 3

echo "Turning USR2 LED off for 3 seconds..."
echo "0" > ${led}usr2/brightness
get_led_state
sleep 3

echo "Turning USR3 LED off for 3 seconds..."
echo "0" > ${led}usr3/brightness
get_led_state
sleep 3

echo "Restoring LEDs to their original state..."
echo "$save0b" > ${led}usr0/brightness
echo "$save1b" > ${led}usr1/brightness
echo "$save2b" > ${led}usr2/brightness
echo "$save3b" > ${led}usr3/brightness
echo "$save0t" > ${led}usr0/trigger
echo "$save1t" > ${led}usr1/trigger
echo "$save2t" > ${led}usr2/trigger
echo "$save3t" > ${led}usr3/trigger
get_led_state