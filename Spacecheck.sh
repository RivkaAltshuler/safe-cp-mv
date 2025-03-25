#!/bin/bash 
. ./MainScript.sh

#check source file/dir size in bytes
soure_file_validation(){
    SOURCE_FILE_SIZE=$(stat -c %s "$SOURCE_FILE")
}       

#check destination free space in bytes
destination_path_validation(){
    DESTINATION_AVAILABLE_SPACE_BEFORE=$(df -P $DESTINATION_PATH | awk 'NR==2 {print $4}')
}
