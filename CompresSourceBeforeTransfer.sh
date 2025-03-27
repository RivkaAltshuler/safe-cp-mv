#!/bin/bash

. ./SpaceCheck.sh

# Function to compress a file or directory
compress_source() {
       	local source="$1"
        $(tar -czf "${source}.tar.gz" "$source")
        echo "${source}.tar.gz"
}

compressed_source_size(){
	local source_file=$1
	compressed_file=$(compress_source "$source_file")
	source_file_size_after=$(source_file_size "$compressed_file")
	echo "$source_file_size_after"
}
