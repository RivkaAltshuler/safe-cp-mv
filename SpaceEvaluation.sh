#!/bin/bash


. ./Logging.sh
. ./SpaceCheck.sh
. ./CompresSourceBeforeTransfer.sh
. ./CompressLargeFileatDestination.sh
. ./DeleteOldFiles.sh
. ./DeleteLargeFiles.sh
. ./SuggestAlternateDestination.sh
. ./PerformOperation.sh


USER_SELECTED_RESOLUTION="No reslution action needed"
OPERATION_PERFORM_STATUS=""
THRESHOLD_DAYS=0
THRESHOLD_FILE_SIZE=7
FIRST_TRY="true"

#size in KB0
DIRECTORY_MAX_SIZE=135

SOURCE_FILE_SIZE=0
DESTINATION_AVAILABLE_SPACE=""
DESTINATION_AVAILABLE_SPACE_BEFORE=""


space_is_sufficient() {
	     
	if [[ "$DESTINATION_AVAILABLE_SPACE" -ge "$SOURCE_FILE_SIZE" ]]; then
		echo "true" # Enough space
	else
		echo "false"  # Not enough space
	fi

}


space_evaluation() {
	
	DESTINATION_AVAILABLE_SPACE_BEFORE=$(destination_available_space "$DESTINATION_PATH" "$DIRECTORY_MAX_SIZE")
	while true; do

		SOURCE_FILE_SIZE=$(source_file_size "$SOURCE_FILE" )
		DESTINATION_AVAILABLE_SPACE=$(destination_available_space "$DESTINATION_PATH" "$DIRECTORY_MAX_SIZE")
		
		local check_sufficient=$(space_is_sufficient)
		echo "Source size: $SOURCE_FILE_SIZE KB"
		echo "Available space at destination: $DESTINATION_AVAILABLE_SPACE KB"


		if [[ $check_sufficient == "true" ]]; then
		        read -p "Proceed with operation? (y/n): " user_confirm
		        if [[ "$user_confirm" != "y" ]]; then
				OPERATION_PERFORM_STATUS="Failure of the $OPERATION operation"
		 		error_logging "Operation cancelled"
			        exit 0
		        fi
			if [[ "$COMPRESS" == "true" ]]; then
			
				echo "Compressing source before transfer..."
		                compressed_source=$(compress_source "$SOURCE_FILE")
				SOURCE_FILE="$compressed_source"
				SOURCE_FILE_SIZE=$(source_file_size "$SOURCE_FILE" )
				
			fi 
				perform_operation
				OPERATION_PERFORM_STATUS="Success of the $OPERATION operation"
				success_logging
				exit 0
		fi
		
		if [[ "$FIRST_TRY" == "true" ]]; then
			resolve_space_issue
	                FIRST_TRY="false"
		else
				echo "Not enough space available at $DESTINATION_PATH , Choose an option:"
				echo "1) Retry Cleanup"
				echo "2) Cancel operation"
	       			while true; do
					read -p "please Enter choice: " choice
  					case $choice in
		    				1) resolve_space_issue
			 			   break;;	
					        2) OPERATION_PERFORM_STATUS="Failure of the $OPERATION operation"
						   error_logging "Operation cancelled"
					           exit 0;;
					        *) echo "Invalid option." ;;
		       			esac
				done
		fi
	done					

}


resolve_space_issue() {

      	echo "Not enough space available at $DESTINATION_PATH. Choose an option:"
     	echo "1) Delete old files"
      	echo "2) Delete large files"
     	echo "3) Compress source before transfer"
 	echo "4) Compress large files at destination"
    	echo "5) Suggest alternate destination"
	while true; do
		read -p "Please enter choice: " choice
		case $choice in
			1) echo "Deleting old files..."
				delete_old_files "$DESTINATION_PATH" "$THRESHOLD_DAYS"
				USER_SELECTED_RESOLUTION="Delete old files"
				break;;
	        	2) echo "Deleting large files..."
		   		delete_large_files "$DESTINATION_PATH" "$THRESHOLD_FILE_SIZE"
				USER_SELECTED_RESOLUTION="Delete large files"
				break;;
	       	        3) echo "Compressing source..."
				SOURCE_FILE=$(compress_source "$SOURCE_FILE")
				USER_SELECTED_RESOLUTION="Compress source before transfer"
				break;;
	        	4) echo "Compressing large files at destination..."
				compress_large_files "$DESTINATION_PATH" "$THRESHOLD_FILE_SIZE"
				USER_SELECTED_RESOLUTION="Compress large files at destination"
				break;;
	        	5) echo "Suggesting alternate destination..."
				suggest_alternate_destination "$SOURCE_FILE_SIZE"
				USER_SELECTED_RESOLUTION="Suggest alternate destination"
				break;;
	       	        *) echo "Invalid option." ;;
		esac
	done
}



