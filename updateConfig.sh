#!/usr/bin/bash

# Backup old config.ini if it exists
if [ -e /home/pi/scripts/homebridgeCLITool/config.ini ]; then
	mv /home/pi/scripts/homebridgeCLITool/config.ini /home/pi/scripts/homebridgeCLITool/config.ini.old
        else
        echo "No previous config.ini to backup, continuing..."
fi
# run nodeJS script which will output config.tmp
node /home/pi/scripts/homebridgeCLITool/updateConfig.js &&
# remove the lines that just contain commas and save to config.ini
tr , '\n' < config.ini.tmp >> config.ini.ini &&
# remove the config.tmp file
rm /home/pi/scripts/homebridgeCLITool/config.tmp
