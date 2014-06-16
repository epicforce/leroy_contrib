@echo off
echo STARTING SERVICE: %SERVICE_NAME% on %COMPUTERNAME%
net start "%SERVICE_NAME%"
exit 0
