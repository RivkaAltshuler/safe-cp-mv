#!/bin/bash 


# Perform copy or move operation based on user choice.

if [[ "$OPERATION" == "--copy" ]]; then #copy file operation.   
    if cp -r "$SOURCE_FILE" "$DESTINATION_PATH"; then  
        OPERATION_PERFORM_STATUS="copy doen succesfully."
    else 
        OPERATION_PERFORM_STATUS="copy failed."
    fi 
elif [[ "$OPERATION" == "--mv" ]]; then #move file operation.
    if mv "$SOURCE_FILE" "$DESTINATION_PATH"; then
        OPERATION_PERFORM_STATUS="Move done succesfully."
    else 
        OPERATION_PERFORM_STATUS="Move file failed."
    fi
else 
    echo "Invalid operation command. Use COPY or MOVE."
    exit 1
fi    

#Function log messages 
log_massege () {
    echo "$(DATE %'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"           
}

#write log operation status.
log_massege "$OPERATION_PERFORM_STATUS" 