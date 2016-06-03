if [ $USER -ne "root" ]; then
 echo "[ERROR] Must be root you are logged in as >>- $USER -<<"
 exit 1
fi
which docker > /dev/null 2>&1
if [ $? -ne 0 ]; then
 curl -fsSL https://get.docker.com/ | sh
fi
