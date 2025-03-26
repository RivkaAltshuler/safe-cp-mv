#!/bin/bash

log_file="logs/safe_copy.log"

check_writable() {
    if [ ! -w "$1" ]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - $1 Error: Destination path is not writable."
        exit 1
    fi
}

check_if_file_exist() {
    if [ ! -e "$1" ]; then
    	echo "$(date +'%Y-%m-%d %H:%M:%S') - $1 "Error: Source path does not exist."
    	exit 1
    fi
}


check_if_file_exist $1
check_writable $2 

