#!/bin/bash

: '
Author: asinghftw
Date: Mar15, 2024
'

_looking_dir="/path/to/dir"
_grab_stat="gstat.txt"
_looking_file="fvr.csv"

trap 'cleanup' SIGINT

cleanup() {
    echo "Existing"
    exit 0
}

while true; do
if [ -e "${_looking_dir}/${_looking_file}" ]; then 
    
git config --global user.email "you@example.com"
  git config --global user.name "Your Name"