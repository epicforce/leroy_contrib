@echo on
if not exist "%COPY_DIR%" md "%COPY_DIR%"
copy /v /y "%CONFIG_TMP_DIR%\%ENVIRONMENT_NAME%-%AGENT_NAME%\%INST_PATH%\*.*" "%COPY_DIR%"
