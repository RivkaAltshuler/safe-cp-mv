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
#OPERATION_PERFORM_STATUS

# adding new variables to acript: minimum file size.       
MIN_SIZE="+100M"              
      
# Find files larger than $min_size, sort them by size, and display the top 3 largest files.
function scan_large_files {
    echo "Scanning for files larger than $MIN_SIZE in $DESTINATION_PATH..."
    log_operation "Started scanning directory $DESTINATION_PATH"

    find "$DESTINATION_PATH" -type f -size "$MIN_SIZE" -exec ls -lh {} \; | awk '{ print $9 ": " $5 }' | sort -k2 -hr | head -n 3

    log_operation "Finished scanning in directory $DESTINATION_PATH"
}

delete_large_files() {
    echo "Scanning for largest files in $DESTINATION_PATH..."
    log_operation "Scanning for large files in $DESTINATION_PATH"

    LARGE_FILES=$(find "$DESTINATION_PATH" -type f -size "$MIN_SIZE" -exec ls -lh {} + | awk '{ print $9, $5 }' | sort -k2 -rh | head -n 3)

        if [[ -z "$LARGE_FILES" ]]; then
        echo "No large files found in $DESTINATION_PATH."
        log_operation "No large files found for deletion."
        return
        fi

    echo "Top 3 largest files:"
    echo "$LARGE_FILES"

    #ask the user if he like to delete the files, part of them or quit. 
    echo "Enter the number of the file you want to delete, or type 'all' to delete all listed files, or 'q' to quit:"
    select file in $(echo "$LARGE_FILES" | awk '{print $1}') "All" "Quit"; do
        if [[ "$file" == "Quit" ]]; then
            echo "Skipping file deletion."
            log_operation "User skipped large file deletion."
            return
        elif [[ "$file" == "All" ]]; then
            echo "Deleting all listed files..."
            echo "$LARGE_FILES" | awk '{print $1}' | xargs rm -f
            log_operation "Deleted all listed large files."
            break
        elif [[ -n "$file" ]]; then
            echo "Deleting $file..."
            rm -f "$file"
            log_operation "Deleted file: $file"
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
}
