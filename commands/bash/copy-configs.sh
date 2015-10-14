# Requires:
# 
# COPY_DIR
# CONFIG_TMP_DIR
# ENVIRONMENT_NAME
# AGENT_NAME
# INST_PATH

if [ ! -d ${COPY_DIR} ]; then
	mkdir ${COPY_DIR}
fi
alias cp='cp'
cp -Rvf ${CONFIG_TMP_DIR}/${ENVIRONMENT_NAME}-${AGENT_NAME}/${INST_PATH}/* ${COPY_DIR}
