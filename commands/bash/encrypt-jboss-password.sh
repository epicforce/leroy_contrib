#!/bin/bash

# Set these 2 paths
BASE_PATH=/home
JAVA_HOME=/usr/java

JBOSSSX=${BASE_PATH}/jboss/lib/jbosssx.jar
JBOSS_LOGGING=${BASE_PATH}/jboss/client/jboss-logging-spi.jar
JAVA=${JAVA_HOME}/bin/java

if [ ! -f $JBOSSSX -o ! -f $JBOSS_LOGGING ]; then
	echo "[ERROR] Missing required jars:"
	echo "$JBOSSSX"
	echo "$JBOSS_LOGGING"
	exit 1
fi

if [ ! -f $JAVA ]; then
	echo "[ERROR] Missing JRE, expected to find it in $JAVA"
	exit 1
fi

ENCRYPTED_PASSWORD=`$JAVA -cp $JBOSSSX:$JBOSS_LOGGING org.jboss.resource.security.SecureIdentityLoginModule $1`
echo $ENCRYPTED_PASSWORD
