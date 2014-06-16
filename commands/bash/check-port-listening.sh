#!/bin/bash
#
#
# Check if a port is listening. An okay way to test if a service has started.
# 8.2.2011
#
#

START=0
MAX=25
INTERVAL=10
PORT=$1
IP=$2
GREP=/bin/grep

if [ -z $1 -a -z $2 ]; then
	echo "[ERROR] Expecting 2 arguments: $0 [PORT] [IP]"
	echo "Usage: $0 [PORT] [IP]"
	exit 1
fi

while [ 1 ]; do
        NUM_MATCHES=`netstat --tcp --listening --numeric-ports --program --numeric-hosts 2>/dev/null | ${GREP} ${IP} | ${GREP} -P "\d:${PORT} " -c`
	if [ $NUM_MATCHES -ge 1 ]; then
		echo "[INFO] Port ${PORT} is listening"
		exit 0
	else
		echo "[INFO] Port ${PORT} is not listening yet... checking again in $INTERVAL seconds for $(($MAX-$START)) more times..."
		sleep $INTERVAL
		let START++
	fi
	
	if [ $START -eq $MAX ]; then
		echo "[ERROR] Maximum amount of attempts tried ($MAX), dying..."
		exit 1		
	fi
done
