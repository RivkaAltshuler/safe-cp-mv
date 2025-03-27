#!/bin/bash 


#check source file/dir size in KB
source_file_size(){
	local source=$1
	local source_size=$(du -k "$source"| awk '{print $1}')
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
