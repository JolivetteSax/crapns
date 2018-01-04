#!/bin/bash

# This is pretty crappy, but that's ok
python3 server.py &> crapns.log &

echo $!
