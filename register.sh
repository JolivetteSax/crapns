#!/bin/bash
name=`hostname`
ip=`hostname -I | sed 's/\s//g'`
crapns=$1
echo "Using crapns server at $1"
echo "Registering $ip with $name"

cat <<EOF | sh
curl -f -i -H "Content-Type: application/json"  -X POST -d '{"ip":"$ip", "name": "$name"}' http://$crapns:5000/register 

EOF


