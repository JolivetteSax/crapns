#!/bin/bash

json=`curl -s -f http://$1:10053/hosts | python -m json.tool`

if [ $? -ne 0 ] ; then
    echo "failed to get hosts"
    exit 127
fi

# cut the crap
orig_hosts=`cat /etc/hosts | sed '/CRAP/,/END OF CRAP/d'`
echo "$orig_hosts

# CRAP
" > hosts

# python argument c for crap
echo $json | python3 -c '
import json
import sys

data = json.load(sys.stdin)
for key, value in data.items():
    print(value + "\t" + key)
' >> hosts

#makes it possible to strip this crap out again in future runs
echo "
#END OF CRAP
" >> hosts

time=`date`
echo "updated hosts at $time"
