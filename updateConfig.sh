#!/usr/bin/bash
source .env
# Backup old config.ini if it exists
if [ -e $MYPATH/config.ini ]; then
	mv $MYPATH/config.ini $MYPATH/config.ini.old
        else
        echo "No previous config.ini to backup, continuing..."
fi
# run nodeJS script which will output config.tmp
node $MYPATH/updateConfig.js &&
# remove the lines that just contain commas and save to config.ini
tr , '\n' < config.ini.tmp >> config.ini.ini &&
# remove the config.tmp file
rm $MYPATH/config.tmp
