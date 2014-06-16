#!/bin/bash
#
#
# Specify BASE_DIR where agent is installed and call this script with cron to keep agent alive.
#
BASE_DIR=/opt/leroy/agent
PID_FILE=${BASE_DIR}/agent.pid

startAgent(){
        touch ${PID_FILE}
        bash ${BASE_DIR}/agent ${PID_FILE} > /dev/null 2>&1 &
        echo ${!} > ${BASE_DIR}/agent.pid
}

if [ -f ${PID_FILE} ]; then
        PID=${PID_FILE}
        ps `cat ${PID_FILE}` > /dev/null 2>&1
        if [ $? -eq 0 ]; then
                exit 0
        else
                startAgent
        fi
else
        startAgent
fi
