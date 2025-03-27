#!/bin/bash

export LOG_FILE="safe_copy.log"

OPERATION=""
SOURCE_FILE=""
DESTINATION_PATH=""
COMPRESS="false"
DRY_RUN="false"
USER_SELECTED_RESOLUTION=""
OPERATION_PERFORM_STATUS=""

#size in KB0
SOURCE_FILE_SIZE_BEFORE=0
SOURCE_FILE_SIZE_AFTER=0
DIRECTORY_MAX_SIZE=1000
DESTINATION_AVAILABLE_SPACE_BEFORE=0
DESTINATION_AVAILABLE_SPACE_AFTER=0

. ./Logging.sh
. ./SpaceCheck.sh
. ./InitialValidation.sh
#. ./SpaceEvaluation

validate_arguments(){

if [[ $# -lt 3 ]];
then
	message="Invalid arguments number , check the usage again !!"
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
	check_if_file_exist $SOURCE_FILE 
	
	DESTINATION_PATH="$3"
	check_writable $DESTINATION_PATH


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

	validate_arguments "$@"
	SOURCE_FILE_SIZE_BEFORE=$(source_file_size  $SOURCE_FILE )
	DESTINATION_AVAILABLE_SPACE_BEFORE=$(destination_available_space $DESTINATION_PATH $DIRECTORY_MAX_SIZE)	
#	space_evaluation $SOURCE_FILE_SIZE_BEFORE $DESTINATION_AVAILABLE_SPACE_BEFORE

}

main "$@" 


