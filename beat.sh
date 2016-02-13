#!/bin/sh

IP=`ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
HOSTNAME=$(hostname)
TIMESTAMP=`date +"%Y-%m-%dT%H:%M:%S.%N%:z"`
TOKEN='<TOKEN>'
LOAD=`uptime | awk -F'[a-z]:' '{ print $2}'`

curl --proxy http://127.0.0.1:3128 --insecure -X POST -d "{\"title\": \"${HOSTNAME}\",\"ip\": \"${IP}\", \"localTimestamp\":\"${TIMESTAMP}\", \"load\":\"${LOAD}\"}" --header "Content-Type: application/json" --header "Authorization: Bearer ${TOKEN}" https://raspbeat.binggl.net/api/receiver/beat
