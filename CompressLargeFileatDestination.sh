#!/bin/bash

compress_large_files() {
    
    destination_path=$1

    echo "Searching for files larger than 10000 bytes in $destination_path..."
    large_files=$(find "$destination_path" -type f -size +10000c)
    
    if [[ -z "$large_files" ]]; then
        echo "No large files were found."
        return 
    fi
    
    echo "The following files are large files:"
    echo "$large_files"
    
    read -p  "Do you want to compress them? (y/n)" confirmation
    
    if [[ "$confirmation" == "y" ]]; then
        
        for file in $large_files; do
            original_size=$(du -b "$file" | awk '{print $1}')
            gzip "$file"
            compressed_size=$(du -b "${file}.gz" | awk '{print $1}')
            saved_space=$((original_size - compressed_size))
            echo "Compressed: $file | original size: $original_size bytes | compressed size: $compressed_size bytes | Saved: $saved_space bytes"
        done
        
        echo "Files were compressed."
    fi


}

compress_large_files "$1"
