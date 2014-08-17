import leroy, os, re, sys
# if leroy.checkRunningLogForStrings(os.path.normpath(os.environ["JBOSS_HOME"]) + "/" + os.environ["JBOSS_SERVER"] + "/log/boot.log", ["JBoss Successfully Started"], 10):
if leroy.checkPortListening(os.environ["JBOSS_PORT"], 25):
 print("JBoss has started")
else:
 print("Timed out waiting for JBoss to start")
 sys.exit(1)
