#!/bin/bash

: '
Author: asinghftw
Date: Mar15, 2024
'

_watch_dir="/asinghftw/shell_script/_file_watcher"
_grab_stat="gstat.txt"
_looking_file="fvr.csv"
#Indian Standard time (IST)
_time_zone="Asia/Kolkata"

#Trap signal for clean exit
trap 'cleanup' SIGINT

cleanup() {
    echo "Existing"
    exit 0
}

while true; do
    ctime=$(TZ="$_time_zone" date +%H%M)
    #checking if the current time is before 18:00 (6:00 PM) in the specified timezone
    if [ "${ctime}" -lt "1800" ]; then
        if [ -e "${_watch_dir}/${_looking_file}" ]; then
            #File is present
            echo "File Available" >"${_grab_stat}"

            #Checking if file is getting updated
            psize=$(stat -f %z "${_watch_dir}/${_looking_file}")
            while true; do
                sleep 1
                csize=$(stat -f %z "${_watch_dir}/${_looking_file}")
                if [ "${csize}" -gt "${psize}" ]; then
                    echo "Alteration: Data Updated at $(date)" >"${_grab_stat}"
                    psize="${csize}"
                elif [ "${csize}" -lt "${psize}" ]; then
                    echo "Alteration: Data Reduced at $(date)" >"${_grab_stat}"
                    psize="${csize}"
                fi
            done
        else
            #File is not present
            echo "File not found" >"$_grab_stat"
            sleep 5
        fi
    else
        #Exit the script after 18:00 in the specified timezone
        echo "Script exited after 18:00 in $_time_zone" >"${_grab_stat}"
        exit
    fi
done
