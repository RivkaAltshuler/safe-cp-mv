#!/bin/bash

. ./Logging.sh

check_writable(){

	if [ ! -w "$DESTINATION_PATH" ]; then
        Message="$DESTINATION_PATH : Destination path is not writable."
        error_logging "$Message"
        exit 1
   	fi
}

check_if_file_exist(){

        if [ ! -e "$SOURCE_FILE" ]; then
   	Message="$SOURCE_FILE : Source path does not exist."
        error_logging "$Message"
        exit 1
        fi
}
 

