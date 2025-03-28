#!/bin/bash

perform_operation() {

	if [[ "$OPERATION" == "cp" ]]; then
		cp "$SOURCE_FILE" "$DESTINATION_PATH"
    	elif [[ "$OPERATION" == "mv" ]]; then
		mv "$SOURCE_FILE" "$DESTINATION_PATH"
	else
		OPERATION_PERFORM_STATUS="Failure"
		error_logging "Invalid operation: $OPERATION"
		exit 1
	fi
	if [[ $? -eq 0 ]]; then
		echo "Operation successful!"
	else
		OPERATION_PERFORM_STATUS="Failure"
		error_logging "$OPERATION operation failed"
		exit 1
																					        fi
}


