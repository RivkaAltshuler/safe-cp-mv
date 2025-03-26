#!/bin/bash

export LOG_FILE="safe_copy.log"

OPERATION=""
SOURCE_FILE=""
DESTINATION_PATH=""
COMPRESS="false"
DRY_RUN="false"
USER_SELECTED_RESOLUTION=""
OPERATION_PERFORM_STATUS=""

#size in KB
SOURCE_FILE_SIZ=0
SOURCE_FILE_SIZE_BEFORE=0
SOURCE_FILE_SIZE_AFTER=0
DIRECTORY_MAX_SIZE=1000
DESTINATION_AVAILABLE_SPACE=0
DESTINATION_AVAILABLE_SPACE_BEFORE=0
DESTINATION_AVAILABLE_SPACE_AFTER=0

. ./Logging.sh
. ./SpaceCheck.sh
#. ./SpaceEvaluation

validate_arguments(){
if [[ $# -lt 3 ]];
then
	message="Invalid arguments number , check the usage again !!"
	echo "$message"
	error_logging "$message"
	exit 1
else 
	case "$2" in
	--copy)
		OPERATION="cp";;
	--mv)
		OPERATION="mv";;
	*)
		message="Invalid operation argument , check the usage again !!"
		error_logging "$message"
		exit 1;;
	esac

	SOURCE_FILE="$1"
	#source_file_validation
	
	DESTINATION_PATH="$3"
	#destination_path_validation

	if [[ "$4" != "" ]];then
		case "$4" in
		       	--compress)
				COMPRESS=true
				case "$5" in
					--dry-run)
			    			DRY_RUN=true ;;
				    	"");;
				     	*)
					     	message="Invalid secound optional argument, check the usage again!!" 
						error_logging "$message"
					        exit 1  ;;
				esac;;
			--dry-run)
				DRY_RUN=true
				case "$5" in
					   --compress)
						   COMPRESS=true ;;
					   "");;
      					   *)
						   message="Invalid secound optional argument, check the usage again!!"
						   error_logging "$message"
                                                   exit 1  ;;
				esac;;

			*)
				message="Invalid optsonal argument , check the usage again !!"
			       	error_logging "$message"
			        exit 1;;
		esac
	fi
fi
}


main(){

validate_arguments $1 $2 $3 $4 $5

	source_file_size
	destination_available_space
#	space_evaluation

}
main $1 $2 $3 $4 $5


