#!/bin/bash
set -e
commandOutput="$(python3 /Volumes/MAC/scripts/hbversion.py)"
if [ $commandOutput = 0 ]
then
  touch hbupdate.flag
else
  rm hbupdate.flag
fi
