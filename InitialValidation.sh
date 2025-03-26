#!/bin/bash
. ./Logging.sh

check_writable() {
    if [ ! -w $SOURCE_FILE ]; then
        Message="$(date +'%Y-%m-%d %H:%M:%S') - $SOURCE_FILE Error: Destination path is not writable."
        error_logging "$Message"
        exit 1
    fi
}

check_if_file_exist() {
    if [ ! -e $SOURCE_FILE ]; then
    	Message="$(date +'%Y-%m-%d %H:%M:%S') - $SOURCE_FILE "Error: Source path does not exist."
        error_logging "$Message"
        exit 1
    fi
}
 

