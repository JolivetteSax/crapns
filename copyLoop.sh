#!/bin/bash

# This script has the job of moving the hosts file to your /etc/hosts with an 
# overwriting copy command as root. It's meant to run forever in the background

# It would be crappy to do the whole 'gethosts' loop and discovery process as root
# This is a crappy way to isolate the security hole created by using crapns

id=`whoami`
if [ "$id" != "root" ] ; then
    echo "This program must run with sudo/root priv"
    exit 1
fi

while inotifywait -e close_write hosts; do
    cp hosts /etc/hosts
done;
