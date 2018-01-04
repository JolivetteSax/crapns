#!/bin/bash
name=`hostname`
ip=`hostname -I | sed 's/\s//g'`
crapns=$1
if [ "$#" -eq 2 ] ; then 
  name=$2
fi
echo "Using crapns server at $1"
echo "Registering $ip with $name"

cat <<EOF | sh
curl -f -i -H "Content-Type: application/json"  -X POST -d '{"ip":"$ip", "name": "$name"}' http://$crapns:10053/register 

EOF


