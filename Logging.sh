#!/bin/bash
. ./MainScript.sh

success_logging(){

	if [ ! -f "$LOG_FILE" ];
	then
		touch "$LOG_FILE"
		echo "Log file created succefully"
	fi

	timestamp=$(date "+%Y_%m_%d %H:%M:%S")
	echo -e "Time : $timestamp\nSource file is : $SOURCE_FILE\nDestination path : $DESTINATION_PATH\nSize of source file : $DESTINATION_PATH\nAvilable destination space befor : $DESTINATION_AVAILABLE_SPACE_BEFORE\nAvilable destination space after : $DESTINATION_AVAILABLE_SPACE_AFTER\nUser selected resolution step : $USER_SELECTED_RESOLUTION\nPerformance : $OPERATION_PERFORM_STATUS\n" >> "$LOG_FILE"

}

error_logging(){
	Message="$1"
	timestamp=$(date "+%Y_%m_%d %H:%M:%S")
	echo -e "Time : $timestamp\nError : $Message\n" >> "$LOG_FILE"
}
