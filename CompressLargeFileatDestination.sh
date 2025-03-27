#!/bin/bash

compress_large_files() {
    
    destination_path=$1

    echo "Searching for files larger than 1000 KB in $destination_path..."
    large_files=$(find "$destination_path" -type f -size +1000k)
    
    if [[ -z "$large_files" ]]; then
        echo "No large files were found."
        return 
    fi
    
    echo "The following files are large files:"
    echo "$large_files"
    
    read -p  "Do you want to compress them? (y/n)" confirmation
    
    if [[ "$confirmation" == "y" ]]; then
        
        for file in $large_files; do
            gzip "$file"
        done
        
        echo "Files were compressed."
    fi
}
