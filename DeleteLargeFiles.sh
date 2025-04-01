#!/bin/bash

delete_large_files(){

	destination_path=$1
        size_threshold=$2  # Size threshold in KB (change as needed)
	
	#Find files larger than the specified size, sorted by size (largest first)
        large_files=$(find "$destination_path" -type f -size +"${size_threshold}k" -exec du -k {} + | sort -nr)

        if [ -z "$large_files" ]; then
		echo "No files larger than $size_threshold KB found in $destination_path."
	else
		file_count=$(echo "$large_files" | wc -l)
		total_size=$(echo "$large_files" | awk '{sum += $1} END {print sum}')
		echo "Found $file_count large files with total size: $total_size KB in $destination_path."
		echo "--------------------------------------------------------"
		
 		#Use a loop to print the table correctly
          	while IFS= read -r line; do
                     size=$(echo "$line" | awk '{print $1}')
                     path=$(echo "$line" | awk '{print substr($0, index($0,$2))}')
                     filename=$(basename "$path")
                     printf "%-10s %-30s %-s\n" "$size" "$filename" "$path"
                     done <<< "$large_files"

		echo "--------------------------------------------------------"
		read -p "Do you want to delete these files? (y/n) " confirmation

		if [[ "$confirmation" == "y" ]]; then

			echo "$large_files" | awk '{print $2}' | xargs rm -f
			echo "Deletion complete!"
		else
			echo "Operation canceled."
		fi
	fi
}
	
