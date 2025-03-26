#!/bin/bash 

#variables:
#LOG_FILE
#DIRECTORY_MAX_SIZE
#SOURCE_FILE
#DESTINATION_PATH
#OPERATION
#SOURCE_FILE_SIZE
#DESTINATION_AVAILABLE_SPACE_BEFORE
#DESTINATION_AVAILABLE_SPACE_AFTER
#USER_SELECTED_RESOLUTION
#OPERATION_PERFORM_STATU

#adding new veriables to script for refrence :
TOTAL_VOLUME=/path/to/directory/=1000 KB #*not sure it is correct or not to use this variable as i did , if not this needs to be configiured properly.
#SELECTED_VOLUME=/path/to/directory/         

# This script is used to suggest an alternate destination to the user.
function scan_free_volume {
    FREE_VOLUME=$(df -h "$TOTAL_VOLUME" | awk 'NR>1 {print $4, $6}' | sort -hr | head -n 30)
    echo "Scanning for free volume space in $TOTAL_VOLUME" 
    log_operation "Started scanning directoryS $TOTAL_VOLUME"
    log_operation "Finished scanning in directoryS $TOTAL_VOLUME"
}

#show user the top 3 free volume space.
function show_free_volume {
    echo "Top 3 free volume space:"
    echo "$FREE_VOLUME" | nl 
}

#ask the user to choose the new destenation to copy to or quit the operation.
    echo "choose desteinations 1-3 to copy to or type 'q' to quit:"
    read -r choice

#execute the user choice.

    if [[ "$choice" =~ ^[1-3]$ ]]; then
    SELECTED_VOLUME=$(echo "$FREE_VOLUME" | sed -n "${choice}p" | awk '{print $2}')
    echo "You selected: $SELECTED_VOLUME"
    elif [[ "$choice" == "c" ]]; then
    echo "Operation canceled."
    else
    echo "Invalid choice."
    fi
