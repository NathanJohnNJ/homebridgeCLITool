#!/bin/bash

# Backup old config.ini if it exists
if [ -e /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.ini ]; then
	mv /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.ini /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.ini.old
        else
        echo "No previous config.ini to backup, continuing..."
fi
# run nodeJS script which will output config.tmp
node /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/updateConfig.js &&
# if above completes successfully remove the lines that just contain commas and save to config.ini
sed -n '/[^ ,]/p' /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.tmp >> /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.ini &&
# if above command completes successfully remove the config.tmp file
rm /Volumes/MAC/coding/NJCodes/gitRepos/homebridgeCLITool/macVersions/config.tmp