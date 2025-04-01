#!/bin/bash 


#check source file/dir size in KB
source_file_size(){
	local source=$1
	
	#Get the allocated size (4 KB for empty files or less if the file size is small)
	local source_size=$(du -k "$source" | awk '{print $1}')
	# If the file is empty, ensure that we return at least 4 KB (allocated block size for most filesystems)
	if [[ "$source_size" -eq 0 ]]; then
		source_size=4
        fi
 	echo "$source_size"	
}       

#check destination free space in KB
destination_available_space(){
	local destination_path=$1
	local directory_max_size=$2
	local destination_size=$(du -sk "$destination_path" | awk '{print $1}') # Get size in KB
	local destination_available_space=$((directory_max_size - destination_size))
	echo "$destination_available_space"

}
