#!/bin/bash
#
# Check if a port has stopped listening
#

START=0
MAX=20
INTERVAL=10
PORT=$1
IP=$2
JBOSS_BIND_ADDRESS=$2
USER_ENV=${system.user_env}
GREP=/bin/grep

if [ -z $1 ]; then
	echo "[ERROR] Expecting 2 arguments: PORT IP and an optional 3rd [INTERVAL]"
	echo "Usage: $0 PORT IP [INTERVAL=10 MAX=25]"
	echo "------------------------------------------"
	echo "Example: $0 80 10.1.1.1"
	echo "Example: $0 80 10.1.1.1 10"
	exit 1
fi

if [ ! -z $3 ]; then
	INTERVAL=$3
fi

if [ ! -z $4 ]; then
	MAX=$4
fi

## Fetch PID(s)
_PID=`netstat --tcp --listening --numeric-ports --program --numeric-hosts 2>/dev/null | ${GREP} ${IP} | ${GREP} -P "\d:${PORT} " | awk '{print $7}' | awk -F/ '{print $1}'`
while [ 1 ]; do
	if [ ! -z "${_PID}" ]; then
		PIDS_ALL_DEAD=1
		for x in ${_PID}
		do
			ps ${x} > /dev/null 2>&1
			if [ $? -eq 0 ]; then
				echo "PID: ${_PID} is still alive, checking again in ${INTERVAL} seconds for $(($MAX-$START)) more times..."
				sleep ${INTERVAL}
				let START++
				PIDS_ALL_DEAD=0
				break
			fi
		done
		
		
		if [ $PIDS_ALL_DEAD -eq 1 ]; then
			echo "PID: ${_PID} is dead"
			sleep 5
			exit 0
		fi
	else
		echo "[ERROR] There was no PID(s) found that was listening on port: ${PORT} and bound to IP: ${IP}"
		exit 0
	fi
	
	if [ $START -eq $MAX ]; then
		echo "[INFO] Maximum amount of attempts tried ($MAX), killing PID ${_PID} that is holding that port ${PORT} on IP ${IP} forcibly..."
		if [ ! -z "${_PID}" ]; then
			for z in ${_PID}
                        do
                        	echo "[INFO] Killing PID ${z}"
                                kill -9 ${z}
                        done
		else
			echo "[ERROR] Unable to determine PID, expected number and got NULL. This should not have happened."
			exit 2
		fi
		exit 0
	fi
done
