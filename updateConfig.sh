#!/usr/bin/bash

node /home/pi/scripts/homebridge/updateConfig.js &&
sed -n '/[^ ,]/p' /home/pi/scripts/homebridge/config.ini