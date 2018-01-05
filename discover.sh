#!/bin/bash

if [ "$#" -eq 1 ] ; then
    remote=$1
    ping $remote -c4
    if [ $? -eq 0 ] ; then
        echo "$remote is up"
        result=`curl -f -m 10 http://$remote:10053/discover`
        if [ $? -eq 0 ] ; then
            exit 0
        fi
    fi
fi

# If the crappy server gets rebooted it might get a different IP from DHCP, this 
# simple port scan script will look for it. It's possible for a malicious actor
# to pose as the crapns server for your network, but then youre network security
# is crappier than this system.

prefix=192.168.1
pings=4

# I'm not sure how high... usually DHCP gives out lower IP's first, occasionally
# some DHCP systems might give out random numbers or at least something in 100 range
for i in $(seq 1 200); do 
    echo $i; 
    remote=$prefix.$i
    ping $remote -c$pings
    if [ $? -eq 0 ] ; then
        echo "Remote host $remote is up"
        # curl operation maxtime 5 seconds, because it's a LAN...
        result=`curl -f -m 5 http://$remote:10053/discover`
        if [ $? -eq 0 ] ; then
            echo "Found server $result at $remote, writing crap.json"
            echo "{\"crapns\": \"$remote\"}" > crap.json
            exit 0
        fi
    fi
done

# discovery process failed
exit 127

