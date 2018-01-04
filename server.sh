#!/bin/bash

# This is pretty crappy, but that's ok
python3 server.py &> crapns.log &

echo "python/flash server started with PID: $!"

# give it a chance to get its crap together
sleep 1

# register this host with external interface IP
# using the localhost interface would trigger the remote address check
./register.sh `hostname -I`
./register.sh `hostname -I` crapns
