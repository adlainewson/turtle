# Quick script to list user quotas using username instead of user identifier  (requires root)

#!/bin/bash
rm user_quotas.txt 2>/dev/null
touch user_quotas.txt
for i in $( ls /home ); do
   echo $i $( sudo quota $i |grep -v File|grep -v Disk | grep -v mapper ) >> user_quotas.txt 2>/dev/null
done

cat user_quotas.txt | column -t | sort -k3 -nr | less
rm user_quotas.txt
