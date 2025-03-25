# safe-cp-mv
Overview :

This project enhances traditional cp (copy) and mv (move) operations by checking available disk space at the target location before performing the transfer. If there isn't enough space, the user is guided through interactive options to safely resolve the issue.

Features :

✅ Pre-check Disk Space before copying/moving files

✅ Interactive User Options when space is low

✅ Supports Compression (--compress flag)

✅ Safe File Deletion Suggestions (old/large files)

✅ Logging of All Operations

Usage
Run the script with the appropriate flags:
- Copying Files (safe_copy.sh)
  ./safe_copy.sh --copy source_path destination_path
- Moving Files (safe_mv.sh)
  ./safe_mv.sh --mv source_path destination_path
- Additional Options
Flag	      Description
--copy	    Perform a copy operation
--mv	      Perform a move operation
--compress	Compress files before transferring
--dry-run	  Simulate the operation without executing it

How It Works :

1-Checks available disk space before moving/copying.
2-If space is sufficient, proceeds after user confirmation.
3-If space is insufficient, prompts the user with resolution options, such as:
  -Deleting old/large files
  -Compressing files before transfer
  -Suggesting an alternate destination
4-Logs all operations for tracking.

Logging : 

All operations are logged in logs/safe_copy.log with details such as:
-Timestamp
-Source & Destination paths
-Space available before & after
-User-selected actions
-Success or failure messages

