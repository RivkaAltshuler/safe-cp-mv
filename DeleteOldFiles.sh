#!/bin/bash
 
delete_old_files() {
    
    destination_path=$1
    threshold=$2
    
    old_files=$(find "$destination_path" -type f -mtime +$threshold)
    
    if [ -z "$old_files" ]; then
        echo "No old files found in $destination_path"
    else
    	file_count=$(echo "$old_files" | wc -l)
	    total_size=$(du -sk $old_files | awk '{sum += $1} END {print sum}')
	    echo "Found $file_count old files with size: $total_size kb in $destination_path"
        read -p "Do you want to delete them? (y/n)" confirmation
        if [[ "$confirmation" == "y" ]]; then
            for file in $old_files; do
                rm -f "$file"
                echo "Deleting $file"
            done
        fi
    fi
}

