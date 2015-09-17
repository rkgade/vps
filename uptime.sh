#!/bin/bash

# Fetch uptime from uptime command and check if it's less than 60 minutes or not.

if [[ -d /tmp/custom_logs/uptime_logs ]]; then
if [[ ! -f uptime.log ]]; then
cd /tmp/custom_logs/uptime_logs
touch uptime.log
fi
else
mkdir /tmp/custom_logs/uptime_logs

cd /tmp/custom_logs/uptime_logs
touch uptime.log
fi

log_file="uptime.log"

up_time=`uptime | awk '{print $3}' | cut -d "," -f 1`
up_since=`uptime | awk '{print $4}' | cut -d "," -f 1`
echo $up_time
check=` awk 'BEGIN {print index("$up_time",":")}'`
echo "Check: $check"
if [ $check -eq 0 ] ; then
minutes=$up_time
else
hours=`echo $up_time | cut -d ":" -f 1`
fi

echo "Running at : " `date` >> $log_file
if [ "$up_since" == "min" ];then
echo "System Restarted" >> $log_file
echo "System up since " $uptime " " $up_since >> $log_file
else
echo "System up and running since" $up_time" "$up_since >> $log_file

fi

echo "">> $log_file

