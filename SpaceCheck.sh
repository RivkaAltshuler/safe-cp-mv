#!/bin/bash 


#check source file/dir size in KB
source_file_size(){
	SOURCE_FILE_SIZE=$(du -h $SOURCE_FILE)
}       

#check destination free space in KB
destination_available_space(){
	
	destination_size=$(du -sk "$DESTINATION_PATH" | awk '{print $1}') # Get size in KB
	DESTINATION_AVAILABLE_SPACE=$((DIRECTORY_MAX_SIZE - destination_size))

}

