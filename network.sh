#!/bin/bash

ps cax | grep vlc
if [ $? -eq 0 ]; then
	echo "vlc is running, it will be exited shortly."
	
	sleep 3
	pkill -9 vlc
fi

while true
	do
	ps cax | grep vlc > /dev/null
	VLC=$?
	PING=$(ping -c2 google.com)
	N=$(echo $PING | grep 'received' | awk -F',' '{ print $2}' | awk '{ print $1}')
	
	if [ $N -ge 1 ]; then
		echo $N" ok"
		if [ $VLC -eq 0 ]; then
			pkill -9 vlc
		fi
	else
		if [ $VLC -ne 0 ]; then
			ORD=$(($(($RANDOM))%13+1))
			echo $PING" launching VLC with file "$ORD
			cvlc  $ORD.mp3 --play-and-exit &
		else
			sleep 1
		fi		
	fi
done


