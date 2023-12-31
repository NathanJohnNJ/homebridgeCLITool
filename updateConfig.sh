#!/usr/bin/bash

node /home/pi/scripts/homebridge/updateConfig.js &&
sed -n '/[^ ,]/p' /home/pi/scripts/homebridge/config.ini


# Backup old config.ini incase of any accidents
mv /home/pi/scripts/homebridge/config.ini /home/pi/scripts/homebridge/config.ini.old
# run nodeJS script which will output config.tmp
node /home/pi/scripts/homebridge/updateConfig.js &&
# if above completes successfully remove the lines that just contain commas and save to config.ini
sed -n '/[^ ,]/p' /home/pi/scripts/homebridge/config.tmp >> /home/pi/scripts/homebridge/config.ini &&
# if above command completes successfully remove the config.tmp file
rm /home/pi/scripts/homebridge/config.tmp