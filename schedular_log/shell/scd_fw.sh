#!/bin/bash

: '
Author: asinghftw
Date: Mar17, 2024
'

_watch_dir="/Users/striver/learning_module/shell_script/schedular_log/shell"
_looking_file="fvr.csv"
#Indian Standard time (IST)
_time_zone="Asia/Kolkata"
LOG_DIR="/Users/striver/learning_module/shell_script/schedular_log/shell"
#1MB
LOG_ROTATE_THRS=1000000
LOG_NUM=1
file_not_found_logged=false
# Variable to store the PID of the background process
scheduler_pid=""

#Fncn to perform task and log it
pfrm_tsk() {
    ctime=$(TZ="${_time_zone}" date +%H%M)
    log_msg "Checking file presence"
    sleep 5
    if [ -e "${_watch_dir}/${_looking_file}" ]; then
        #File is present
        log_msg "File is present"
        file_not_found_logged=false

        #Checking if file is getting updated
        psize=$(stat -f %z "${_watch_dir}/${_looking_file}")

        while true; do
            sleep 1
            csize=$(stat -f %z "${_watch_dir}/${_looking_file}")
            if [ "${csize}" -gt "${psize}" ]; then
                log_msg "Alteration: Data Updated"
                psize="${csize}"
            elif [ "${csize}" -lt "${psize}" ]; then
                log_msg "Alteration: Data Reduced"
                psize="${csize}"
            fi
        done
    else
        #File is not present
        if ! $file_not_found_logged; then
            log_msg "File not found: ${_watch_dir}/${_looking_file} No such file present in the directory"
            file_not_found_logged=true
        fi
        sleep 5
    fi
}

#Funcn to check log message with timestamp
log_msg() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >>"${LOG_DIR}/scheduler_filewatcher_log_${LOG_NUM}.log"
    chk_log_rotation
}

#Funcn to check the log file size and rotate if necessary
chk_log_rotation() {
    log_size=$(stat -f %z "${LOG_DIR}/scheduler_filewatcher_log_${LOG_NUM}.log")
    if [ -n "$log_size" ] && [ "${log_size}" -ge "${LOG_ROTATE_THRS}" ]; then
        rotate_log
    fi
}

#Funcnto rotate log file
rotate_log() {
    LOG_NUM=$((LOG_NUM + 1))
}

#fncn to handle script termination
terminate_script() {
    echo "Terminating script..."
    # Kill the background process if it's running
    if [ -n "$scheduler_pid" ]; then
        echo "Killing scheduler (PID: $scheduler_pid)..."
        kill "$scheduler_pid" # Kill the background process
        echo "Scheduler killed."
    else
        echo "Scheduler PID not found or empty."
    fi
    echo "Script terminated."
    exit
}

#Scheduler fncn
scheduler() {
    while true; do
        pfrm_tsk
        #Checking current ime and exit script if after 18:00 in specified timezone
        crr_hour=$(TZ="${_time_zone}" date +%H%M)
        if [ "${crr_hour}" -ge "1800" ]; then
            log_msg "Script exited after 18:00 in ${_time_zone}"
            exit
        fi
    done
}

#Main Fncn
main() {
    #Checking if log file already exists
    while [ -e "${LOG_DIR}/scheduler_filewatcher_log_${LOG_NUM}.log" ]; do
        LOG_NUM=$((LOG_NUM + 1))
    done
    echo "Starting scheduler..."
    scheduler &
    # Wait for a short period to allow the background process to start
    sleep 1
    if [ -n "$!" ]; then
        scheduler_pid="$!"
        echo "Scheduler started with PID: $scheduler_pid"
    else
        echo "Failed to start scheduler. Exiting script."
        exit 1
    fi
    #Log scheduler start
    log_msg "Scheduler started"
    #wait for scheduler to finish (will never happen)
    wait
}
trap 'terminate_script' SIGINT
#Calling main fncn
main
