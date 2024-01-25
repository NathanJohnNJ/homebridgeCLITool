#!/bin/bash
source .env
if [ "$1" = "help" ];
	then
	echo "Use this command like so:"
	echo "		toggle <DEVICE TO CONTROL>"
	echo "		The following devices can be controlled by using the given code word:"
	echo "		Beauty Lamp: beauty"
	echo "		Bed Chargers: bchargers"
	echo "		Desk Chargers: dchargers"
	echo "		Desk Lamp: desk"
	echo "		Main Light: main"
	echo "		Mirror Lights: mirror"
	echo "		Speakers: speakers"
	echo "		Wardrobe Lightstrip: wardrobe"
	else
	state=$($MYPATH/getstate.sh $1)
	if [ $state -eq 1 ]; then
		until [ $state -eq 0 ]; do
			$MYPATH/off.sh $1
			echo "$1 is now off."
			break
		done
	else
			until [ $state -eq 1 ]; do
			$MYPATH/on.sh $1
					echo "$1 is now on."
			break
		done
	fi
fi
