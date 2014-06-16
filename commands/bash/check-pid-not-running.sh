function checkPidNotRunning {
	START=1
	
	if [ -z ${1} ]; then
		echo "[ERROR] Expecting 1 argument: PID"
		echo "Usage: $0 PID"
		echo "------------------------------------------"
		echo "Example: $0 123"
		exit 1
	else
		_PID=${1}
	fi
	
	if [ ! -z $3 ]; then
		INTERVAL=$3
	else
		INTERVAL=10
	fi
	
	if [ ! -z $4 ]; then
		MAX=$4
	else
		MAX=20
	fi
	
	## Fetch PID(s)
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
				return 0
			fi
		else
			echo "[ERROR] There was no PID(s) found that was listening on port: ${PORT} and bound to IP: ${IP}"
			return 0
		fi
		
		if [ $START -eq $MAX ]; then
			echo "[INFO] Maximum amount of attempts tried ($MAX), killing PID ${_PID} forcibly..."
			if [ ! -z "${_PID}" ]; then
				for z in ${_PID}
				do
					echo "[INFO] Killing PID ${z}"
					kill -9 ${z}
				done
			else
				echo "[ERROR] Unable to determine PID, expected number and got NULL. This should not have happened."
				return 2
			fi
			return 0
		fi
	done
}

## Stop command here

# checkPidNotRunning `cat PIDFILE`


## Clean up any leftover mess
KILL_TARGET=7.1.1.Final
echo "[INFO] Killing all processes that contain the string: ${KILL_TARGET}"
for x in `ps auxwwww | grep ${USER} | grep ${KILL_TARGET} | grep -v grep | awk '{print $2}'`
do
         ps ${x} > /dev/null 2>&1
         if [ $? -eq 0 ]; then
                 echo "[INFO] Killing ${x}"
                 kill -9 ${x}
         fi
done
