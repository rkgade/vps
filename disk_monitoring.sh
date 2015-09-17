#!/bin/bash
EMAIL=jupiter@quikappt.com
#EMAIL=kiran@rajkiran.me

# script to monitor disk usage.
# if the below line is uncommented, df -H command output is shown on output.
df -H | grep -v "Filesystem" | awk '{print $1 " " $5 "  " $6}' | while read output;
# replace above statement so that output is not displased on the output.
do
        #echo $output
        usep=$(echo $output | awk '{print $2'} | cut -d "%" -f1)
        partition=$(echo $output | awk '{print $1'})
        mount_point=$(echo $output | awk '{print $3}')
        if [[ $mount_point == '/' ]]; then
                if [ $usep -ge 75 ]; then
                        echo "Running out of space \"Partition :($partition)\" on $HOSTNAME as on $(date)."
                        echo "Consumed space as of now :" $usep
                        echo "Running out of space \"Partition :($partition)\" on $HOSTNAME as on $(date)." | mailx -s "** ALERT ** for `hostname` " "${EMAIL}"
                fi
        fi
done
