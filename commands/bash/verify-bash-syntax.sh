#!/bin/bash

CHECK_PATH=.
## Validate shell script syntax
echo "Checking bash scripts for syntax errors..."
for x in `ls -1 ${CHECK_PATH}/*.sh`
do
	bash -n $x
	if [ $? -eq 0 ]; then
		echo "[OK] $x"
	else
		echo "[ERROR] Syntax error in $x"
		exit 10
	fi
done
