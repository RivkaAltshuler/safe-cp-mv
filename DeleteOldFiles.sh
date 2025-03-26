#!/bin/bash

delete_old_files() {
    destination_path=$1
    threshold=$2
    
    old_files=$(find "$destination_path" -type f -mtime +$threshold)
    file_count=$(echo "$old_files" | wc -l)
    total_size=$(du -ch $old_files 2>/dev/null | grep total$ | awk '{print $1}')
    
    echo "Found $file_count old files with size: $total_size."
    read -p "Do you want to delete them? (y/n)" confirmation
    if [[ "$confirmation" == "y" ]]; then
        for file in $old_files; do
            rm -i "$file"
        done
        echo "Old files deleted."
    fi
}
