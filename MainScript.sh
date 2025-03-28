#!/bin/bash

export LOG_FILE="safe_copy.log"

OPERATION=""
SOURCE_FILE=""
DESTINATION_PATH=""
COMPRESS="false"
DRY_RUN="false"

. ./Logging.sh
. ./InitialValidation.sh
. ./SpaceEvaluation.sh
. ./PerformOperation.sh

validate_arguments(){

	if [[ $# -lt 3 ]];
	then
		message="Invalid arguments number , check the usage again !!"
		error_logging "$message"
		exit 1
	fi

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

echo "$OPERATION $SOURCE_FILE $DESTINATION_PATH $COMPRESS $DRY_RUN"

}

main() {
	    validate_arguments "$@" 
	    space_evaluation 
	}

main "$@"


