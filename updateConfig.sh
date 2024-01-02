#!/usr/bin/bash

# Backup old config.ini
mv /home/pi/scripts/homebridgeCLITool/config.ini /home/pi/scripts/homebridgeCLITool/config.ini.old
# run nodeJS script which will output config.tmp
node /home/pi/scripts/homebridgeCLITool/updateConfig.js &&
# remove the lines that just contain commas and save to config.ini
sed -n '/[^ ,]/p' /home/pi/scripts/homebridgeCLITool/config.tmp >> /home/pi/scripts/homebridgeCLITool/config.ini &&
# remove the config.tmp file
rm /home/pi/scripts/homebridgeCLITool/config.tmp
