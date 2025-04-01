#!/bin/bash

# Function to suggest an alternate destination with more space
suggest_alternate_destination() {

	echo "Scanning for available storage locations..."
	local source_size="$1"
	
	#Get a list of mounted filesystems sorted by available space (descending)
	available_mounts=()
	while IFS= read -r line; do
        mount_point=$(echo "$line" | awk '{print $1}')
	used_space=$(echo "$line" | awk '{print $2}')
        
	#Calculate available space as 60 - used space
	available_space=$((DIRECTORY_MAX_SIZE - used_space))
	if [[ "$available_space" -ge "$source_size" ]];then 
		available_mounts+=("$mount_point $available_space KB")
	fi
	done < <(df -k --output=target,used | tail -n +2 | sort -nk2)


 
	if [[ ${#available_mounts[@]} -eq 0 ]]; then
		echo "No alternate storage locations found."
		return 1
	fi

        
	echo "Top 3 locations with the most available space:"
	echo "----------------------------------------------"
	# Display top 3 locations
	for i in {0..2}; do
       		if [[ -n "${available_mounts[i]}" ]]; then
  	        mount_point=$(echo "${available_mounts[i]}" | awk '{print $1}')
                free_space=$(echo "${available_mounts[i]}" | awk '{print $2}')
	        echo "$((i+1))) $mount_point - Free space: $free_space KB"
	       	fi
	 done
   	 echo "----------------------------------------------"

	# Prompt user to select a destination or cancel
         while true; do
	       	 read -p "Enter the number of the new destination (or 0 to cancel): " choice
    		 if [[ "$choice" =~ ^[0-3]$ ]]; then
      			 if [[ "$choice" -ge 1 && "$choice" -le 3 ]]; then
			      	 destination_path=$(echo "${available_mounts[((choice-1))]}" | awk '{print $1}')
			         echo "Selected destination : $destination_path"  # Return the selected destination
				 DESTINATION_PATH="$destination_path"
				 return 0
			 else
				 echo "Operation canceled."
				 return 1
			 fi
			 break
		 else
			 echo "Invalid selection. Please enter 1, 2, 3, or 0 to cancel."
			 
		 fi
	 done
 }




