#!/bin/bash


#Print success operation performe to the safe_copy.log file
success_logging(){

	if [ -z "$LOG_FILE" ]; then
		
	         echo "Error: LOG_FILE is not set!"
		         exit 1
			     fi

	if [ ! -f "$LOG_FILE" ];
	then
		touch "$LOG_FILE"
		echo "Log file created succefully"
	fi

	timestamp=$(date "+%Y_%m_%d %H:%M:%S")
	echo -e "Time : $timestamp\nSource file is : $SOURCE_FILEE\nDestination path : $DESTINATION_PATHE\nSize of source file : $DESTINATION_PATHE\nAvilable destination space befor : $DESTINATION_AVAILABLE_SPACE\nAvilable destination space after : $DESTINATION_AVAILABLE_SPACE_AFTER\nUser selected resolution step : $USER_SELECTED_RESOLUTION\nPerformance : $OPERATION_PERFORM_STATUS\n" >> "$LOG_FILE"

}

#Print faiulre operation perform or Error message
error_logging(){

	if [ ! -f "$LOG_FILE" ] ;
	then
		touch "$LOG_FILE"
	       	echo "Log file created succefully"
      	fi

	Message="$1"
	timestamp=$(date "+%Y_%m_%d %H:%M:%S")
	echo -e "Time : $timestamp\nError : $Message\n" >> "$LOG_FILE"
}

