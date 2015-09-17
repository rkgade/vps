#!/bin/bash

# Check for oracle listener.
oracle_instance=`nmap -sT -O localhost | grep "oracle"`

if [[ -d /tmp/custom_logs/proc_mgmt_logs ]]; then
if [[ ! -f proc_mgmt.log ]]; then
cd /tmp/custom_logs/proc_mgmt_logs
touch proc_mgmt.log
fi
else
mkdir /tmp/custom_logs/proc_mgmt_logs

cd /tmp/custom_logs/proc_mgmt_logs
touch proc_mgmt.log
fi

log_file="proc_mgmt.log"


if [[ -z $oracle_instance ]]; then
echo"At"`date`"::" " Oracle Instance not up and running." >> $log_file
else
echo $oracle_instance
port=`echo "$oracle_instance" | awk '{print $1}' `
service=`echo "$oracle_instance" | awk '{print $3}' `
status=`echo "$oracle_instance" | awk '{print $2}' `

echo "At"`date` "::" $service $status "on" $port  >> $log_file
fi
