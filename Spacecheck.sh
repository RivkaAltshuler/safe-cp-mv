#!/bin/bash 

#variables:
#LOG_FILE
#DIRECTORY_MAX_SIZE
#SOURCE_FILE
#DESTINATION_PAATH
#OPERATION
#SOURCE_FILE_SIZE
#DESTINATION_AVAILABLE_SPACE_BEFORE
#DESTINATION_AVAILABLE_SPACE_AFTER
#USER_SELECTED_RESOLUTION
#OPERATION_PERFORM_STATUS

#check srcoe file/dir size in bytes
function check_source_size(){
    SOURCE_FILE_SIZE=$(stat -c %s "$SOURCE_FILE")
}       

#check destination free space in bytes
function check_destination_free_space(){
    DESTINATION_FREE_SPACE_BEFORE=$(df -P $DESTINATION_PATH | awk 'NR==2 {print $4}')
}
