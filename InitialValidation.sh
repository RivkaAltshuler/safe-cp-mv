#!/bin/basih

. ./Logging.sh

check_writable(){
	local destination_path=$1
	if [ ! -w "$destination_path" ]; then
        Message="$destination_path : Destination path is not writable."
        error_logging "$Message"
        exit 1
   	fi
}

check_if_file_exist(){
	local source_file=$1
        if [ ! -e "$source_file" ]; then
   	Message="$source_file : Source path does not exist."
        error_logging "$Message"
        exit 1
        fi
}
 

