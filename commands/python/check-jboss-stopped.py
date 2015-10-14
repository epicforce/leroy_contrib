import leroy, os, re, sys
print("Checking to ensure port: " + os.environ["JBOSS_PORT"] + " is no longer listening")
if leroy.checkPortNotListening(os.environ["JBOSS_PORT"], 10):
 print("JBoss has stopped")
else:
 print("JBoss will not stop")
 sys.exit(1)
