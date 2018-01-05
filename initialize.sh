#!/bin/bash


# This was the crappiest way I found on SO to do get json keys in bash
json_key() {
    python3 -c '
import json
import sys

data = json.load(sys.stdin)

for key in sys.argv[1:]:
    try:
        data = data[key]
    except TypeError:  # This is a list index
        data = data[int(key)]

print(data)' "$@"
}

# First, discover the crapns server on the network
# Then register this hostname with that server
# Begin polling process to check for changes sometimes

crapIP=""
if [ -f crap.json ] ; then
    crapIP=`cat crap.json | json_key crapns`
fi

./discover.sh $crapIP

if [ $? -ne 0 ] ; then
    echo "Failed to discover crapns running on the lan..."
    exit 1
fi

crapIP=`cat crap.json | json_key crapns`

./register.sh $crapIP

# launch polling/sleeping script
while true ; do
    ./getHosts.sh $crapIP
    sleep 60
done

