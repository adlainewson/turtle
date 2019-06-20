#!/bin/sh
kill `cat /home/$USER/.vnc/*.pid` 2>/dev/null
rm /home/$USER/.vnc/*.pid 2>/dev/null
screen -S VNC -d -m vncserver -localhost -autokill
sleep 2s
echo "VNC port is:"
ls /home/$USER/.vnc/*.pid |sed 's/.*turtle.econ.ubc.ca://g' -|sed 's/.pid//g' -
