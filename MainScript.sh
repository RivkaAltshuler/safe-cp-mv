#!/bin/bash

. ./Logging.sh
. ./SpaceCheck.sh
#. ./SpaceEvaluation

LOG_FILE="safe_copy.log"
OPERATION=""
SOURCE_FILE=""
DESTINATION_PATH=""
COMPRESS=false
DRY_RUN=false
USER_SELECTED_RESOLUTION=""
OPERATION_PERFORM_STATUS=""

#size in KB
SOURCE_FILE_SIZE=0
SOURCE_FILE_SIZE_BEFORE=0
SOURCE_FILE_SIZE_AFTER=0
DIRECTORY_MAX_SIZE=1000
DESTINATION_AVAILABLE_SPACE=0
DESTINATION_AVAILABLE_SPACE_BEFORE=0
DESTINATION_AVAILABLE_SPACE_AFTER=0

validate_arguments(){
if [[ $# -lt 3 ]];
then
	message="Invalid arguments number , check the usage again !!"
	echo "$message"
	error_logging "$message"
	exit 1
else 
	case "$1" in
	--copy)
		OPERATION="cp";;
	--mv)
		OPERATION="mv";;
	*)
		message="Invalid operation argument , check the usage again !!"
		error_logging "$message"
		exit 1;;
	esac

	SOURCE_FILE="$2"
	source_file_validation
	
	DESTINATION_PATH="$3"
	destination_path_validation

	if [[ "$4" != "" ]];then
		case "$4" in
		       	--compress)
				COMPRESS=true
				if [[ "$5" != "" ]] && [[ "$5" == "--dry-run" ]];then
					DRY_RUN=true
				else
					message="Invalid optional argument , check the usage again !!"
					error_logging "$message"
					exit 1
				fi;;

			--dry-run)
				DRY_RUN=true
				if [[ "$5" != "" ]] && [[ "$5" == "--compress" ]];then
					COMPRESS=true
				else
			      		message="Invalid optional argument , check the usage again !!"
					error_logging "$message"
					exit 1
				fi;;

			*)
				message="Invalid optional argument , check the usage again !!"
			       	error_logging "$message"
			        exit 1;;
		esac
	fi
fi
}

main(){

	validate_arguments
	source_file_size
	destination_available_space
#	space_evaluation

}

main
