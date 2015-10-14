#!/bin/bash
PWD=`dirname $0`
crontab -l | grep -v ${PWD}/check-agent-running > /tmp/o
if [ ${?} -ne 0 ]; then
 echo "*/3 * * * *  cd ${PWD}; ${PWD}/check-agent-running.sh > /dev/null 2>&1" > /tmp/o
else
 echo "*/3 * * * *  cd ${PWD}; ${PWD}/check-agent-running.sh >> /dev/null 2>&1" >> /tmp/o
fi
${PWD}/check-agent-running.sh
crontab /tmp/o
rm -rf /tmp/o
echo "== Agent installed in crontab running as: ${USER} =="
crontab -l
