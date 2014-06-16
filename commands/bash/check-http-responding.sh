#!/bin/bash
#
# Check if a string exists at a particular url.

WGET=/usr/bin/wget
CURL=/usr/bin/curl
START=0
INTERVAL=5
URL=$1
STRING=$2
STRING2=$3

if [ -z "${4}" ]; then
	MAX=10
else
	MAX=${4}
fi

if [ -z "$1" -a -z "$2" ]; then
	echo "[ERROR] Expecting at least 2 arguments: $0 [URL] [STRING]"
	echo "Usage: $0 [URL] [STRING] [STRING2] [MAXTRIES=10]"
	exit 1
fi

while [ 1 ]; do
	${WGET} --no-check-certificate --dns-timeout=5 --connect-timeout=5 -qO- ${URL} | grep "${STRING}" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "[INFO] URL: ${URL} contains string: ${STRING} - Great!"
		exit 0
	fi
	
	${CURL} -s -I -k --connect-timeout 5 ${URL} | grep ${STRING2} > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "[INFO] URL: ${URL} is sending SSO redirect to: ${STRING2} - Great!"
		exit 0
	else
		echo "[INFO] URL: ${URL} is not responsive yet. Checking again in ${INTERVAL} seconds for $(($MAX-$START)) more times..."
		sleep $INTERVAL
		let START++
	fi
	
	if [ $START -eq $MAX ]; then
		echo "Maximum amount of attempts tried ($MAX), dying..."
		exit 1		
	fi
done
