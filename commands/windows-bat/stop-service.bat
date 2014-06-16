@echo off

REM TODO: Let's validate SERVICE_NAME and SERVICE_FILE environment variables.

REM Let's ask service to stop...
REM Note: NET STOP will wait on the service to stop before it returns to the command prompt.
net stop "%SERVICE_NAME%"

REM Now let's kill the process (if it is still running).
REM Note: taskkill will return non-zero exit code in case the process not found.
REM It returns 0 only when the process was killed successfully.
taskkill /IM "%SERVICE_FILE%" /F > NUL 2>&1
if "%ERRORLEVEL%" == "0" ( 
    echo [INFO] %SERVICE_FILE% was forceably killed )
	
REM TODO: What if the process found, but taskkill failed to kill it (e.g. access is denied)?
REM Maybe implement better handling of errorlevel in here?
	
exit 0
