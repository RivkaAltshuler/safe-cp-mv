#!/bin/bash

. ./SpaceCheck.sh

compress_large_files() 
{    
    destination_path=$1
    size_threshold=$2

    echo "Searching for files larger than $size_threshold kb in $destination_path..."
       large_files=$(find "$destination_path" -type f -size +"${size_threshold}k" -exec du -k {} + | sort -nr)

    if [[ -z "$large_files" ]]; then
        echo "No files larger than $size_threshold KB found in $destination_path."
        return 
    fi
    
    file_count=$(echo "$large_files" | wc -l) 
    total_size=$(echo "$large_files" | awk '{sum += $1} END {print sum}')

    echo "Found $file_count large files with total size: $total_size KB in $destination_path."

    #Use a loop to print the table correctly
    while IFS= read -r line; do
    size=$(echo "$line" | awk '{print $1}')
    path=$(echo "$line" | awk '{print substr($0, index($0,$2))}')
    filename=$(basename "$path")
    printf "%-10s %-30s %-s\n" "$size" "$filename" "$path"
    done <<< "$large_files"
    
    read -p  "Do you want to compress them? (y/n)" confirmation
    
    if [[ "$confirmation" == "y" ]]; then
        saved_space=0
	while IFS= read -r line; do
        file=$(echo "$line" | awk '{print substr($0, index($0,$2))}')
        original_size=$(source_file_size "$file")
        gzip "$file"
        compressed_size=$(source_file_size "${file}.gz")
        saved_space=$((saved_space + original_size - compressed_size))
        done <<< "$large_files"
        echo "Saved space: $saved_space kb"        
        echo "Files were compressed."
    fi
}
