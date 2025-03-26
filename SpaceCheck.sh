#!/bin/bash 
. ./MainScript.sh

#check source file/dir size in Kbytes
soure_file_validation(){
	SOURCE_FILE_SIZE=$(du -h $SOURCE_FILE)
}       

#check destination free space in Kbytes
destination_path_validation(){
    DESTINATION_AVAILABLE_SPACE_BEFORE=$(du -sh $DESTINATION_PATH)
}

