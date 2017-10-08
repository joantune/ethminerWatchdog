#!/bin/bash
limit=70
watchCmd="/usr/bin/nvidia-smi -q -d POWER | grep \"Power Draw\" | sed 's/[^0-9,.]*//g' | cut -d . -f 1"

startIn=30

echo "Watchdog: Waiting $startIn s untill activating watchdog"
sleep $startIn;
echo "Watchdog started!"
while :
do
	currentPowerUsage=$(eval ${watchCmd})
	#echo "Current power usage is $currentPowerUsage"
	if [ "$currentPowerUsage" -lt "$limit" ]
	then
		echo "`date`: Current power usage is $currentPowerUsage < $limit killing miner" | tee watchdogLog.log
		killall ethminer ; sleep 1; killall -9 ethminer
		sleep 20;
	fi
	sleep 10;


done
