#!/bin/bash
if [ "$1" = "help" ];
	then
	echo "Use this command like so:"
	echo "		toggle <DEVICE TO CONTROL>"
	echo "		The following devices can be controlled by using the given code word:"
	echo "		Beauty Lamp: beauty"
#	echo "		Bed Chargers: bchargers"
#	echo "		Desk Chargers: dchargers"
	echo "		Desk Lamp: desk"
#	echo "		Diffuser Power: diffuser"
#	echo "		Drawers Lightstrip: drawers"
#	echo "		Drill Charger: drill"
#	echo "		Empty: empty"
#	echo "		Google Power: google"
#	echo "		Hairdryer: hair"
#	echo "		Hoover: hoover"
#	echo "		Magic Mirror Power: magic"
	echo "		Main Light: main"
	echo "		Mirror Lights: mirror"
	echo "		Speakers: speakers"
#	echo "		Straighteners: straight"
#	echo "		Toiletries Chargers: toiletries"
#	echo "		Wardrobe Lightstrip: wardrobe"
	else
	state=$(/home/pi/scripts/homebridge/getstate.sh $1)
	if [ $state -eq 1 ]; then
		until [ $state -eq 0 ]; do
			/home/pi/scripts/homebridge/off.sh $1
			echo "$1 is now off."
			break
		done
	else
			until [ $state -eq 1 ]; do
			/home/pi/scripts/homebridge/on.sh $1
					echo "$1 is now on."
			break
		done
	fi
fi
