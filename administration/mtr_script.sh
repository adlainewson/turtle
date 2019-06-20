#!/bin/sh
size=0
while [ $size -lt 900 ]
do
   mtr -rw nmc.econ.ubc.ca >> network_log.log
   size="$( du network_log.log | awk '{ print $1 }')" 
done
