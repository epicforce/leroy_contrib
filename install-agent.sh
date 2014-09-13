#!/bin/bash
PWD=`pwd`
crontab -l | grep -v check-agent-running > /tmp/o
echo "*/3 * * * *  cd ${PWD}; ${PWD}/check-agent-running.sh > /dev/null 2>&1" >> /tmp/o
crontab /tmp/o
rm -rf /tmp/o
echo "== Agent installed in crontab running as: ${USER} =="
crontab -l
