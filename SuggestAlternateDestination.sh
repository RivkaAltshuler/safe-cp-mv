#!/bin/bash 

#Function to suggest alternate destination with more space
 suggest_alternate_destination() {
    	 echo "Scanning for available storage locations..."
	 # Get a list of mounted filesystems sorted by available space (descending)
	 local available_mounts=($(df -h --output=target,avail | tail -n +2 | sort -rk2 | awk '{print $1, $2}'))
   	 if [[ ${#available_mounts[@]} -eq 0 ]]; then
		 echo "No alternate storage locations found."
		 return
	 fi
        
	 # Display the top 3 locations with the most space
         echo "Top 3 locations with the most available space:"
         for i in {0..2}; do
	     	 [[ -n "${available_mounts[i]}" ]] && echo "$(($i+1))) ${available_mounts[i]}"
                 done
	 # Prompt user to select a new destination
         read -p "Enter the number of the new destination (or 0 to cancel): " choice
         if [[ $choice -ge 1 && $choice -le 3 ]]; then
	 	 new_destination=$(echo "${available_mounts[$((choice-1))]}" | awk '{print $1}')
		 echo "New destination selected: $new_destination"
                 destination_path="$new_destination"
	 else
                 echo "Operation canceled."
         fi
}    
