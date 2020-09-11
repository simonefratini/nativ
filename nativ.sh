#!/bin/bash
#set static ip for your Nativ Vita
IP=192.168.178.22
MOUNTED=0
# set your mounting point in your ubuntu box
MOUNTING_POINT=/media/simone/vita

is_mounted()
{
  MOUNTED=$(mount | grep $IP | wc -l)
}

set_mount()
{
  sudo mount.cifs //$IP/vita $MOUNTING_POINT -o guest,rw,vers=1.0,uid=1000,forceuid,gid=1000
}
# 
is_reachable()
{
  ping -c1 -q -W3 $IP 
  if [ "$?" -gt "0" ]; then
      zenity --width=120 --error --title=" Nativ Vita " --text "Offline" 2>/dev/null
      exit 1
  fi
}
echo "$0 check..."
is_reachable
is_mounted
while [ "$MOUNTED" -eq "0" ]
do
  set_mount
  sleep 1
  is_mounted 
done   
zenity --width=120 --info --title=" Nativ Vita " --text "Mounted" 2>/dev/null


