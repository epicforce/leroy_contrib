#!/bin/sh
#
#
# Call this script with cron to keep the agent existing in the same directory alive.

BASE_DIR=`dirname $0`
PID_FILE=${BASE_DIR}/agent.pid

startAgent(){
        touch ${PID_FILE}
        ${BASE_DIR}/agent >> ${BASE_DIR}/.start_agent.out 2>&1 &
        echo ${!} > ${PID_FILE}
}

if [ -f ${PID_FILE} ]; then
        PID="`cat ${PID_FILE}`"
        if [ "$PID" != "" ]; then
                ps "$PID" | grep --silent -w agent
                if [ $? -eq 0 ]; then
                        exit 0
                fi
        fi
fi

startAgent
