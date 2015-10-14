#!/bin/bash

USER_ENV=${system.user_env}
ABSTARTER=ABstarter
TOOLS_DIR=/local/${USER_ENV}/tools
ABSTARTER_DIR=/local/${ABSTARTER}/${USER_ENV}

## Check tools dir syntax
TOOLS_ERROR_CONDITION=0
for x in `ls -1 ${TOOLS_DIR}/*.sh`
do
	bash -n ${x} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "[ERROR] BASH syntax check has failed for: ${x}"
		TOOLS_ERROR_CONDITION=1
	else
		echo "[INFO] BASH syntax check ok: ${x}"
	fi
done

## Check startup scripts
ABSTARTER_ERROR_CONDITION=0
for x in `ls -1 ${ABSTARTER_DIR}/Z*`
do
	bash -n ${x} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "[ERROR] BASH syntax check has failed for: ${x}"
		ABSTARTER_ERROR_CONDITION=1
	else
		echo "[INFO] BASH syntax check ok: ${x}"
	fi
done

## Check .bash_profile
bash -n ~/.bash_profile > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "[ERROR] BASH syntax check has failed for: ~/.bash_profile"
	ABSTARTER_ERROR_CONDITION=1
else
	echo "[INFO] BASH syntax check ok: ~/.bash_profile"
fi

if [ ${ABSTARTER_ERROR_CONDITION} -ne 0 -o ${TOOLS_ERROR_CONDITION} -ne 0 ]; then
	echo "[ERROR] BASH syntax check failed";
	exit 1
else
	echo "[INFO] Syntax check completed for all scripts"
	exit 0
fi


