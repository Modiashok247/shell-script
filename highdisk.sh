#!/bin/bash
DISK_THRESHOLD=20
DISK_USAGE=$(df -Th | grep -vE 'tmpfs|Filesystem' | awk '{print $6 " " $1}')
message=""

while IFS= read -r line; do
  usage=$(echo "$line" | cut -d "%" -f1)
  partition=$(echo "$line" | cut -d " " -f2)

  echo "usage: $usage"
  echo "partition: $partition"

  if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
    message+="High Disk usage on $partition: $usage%\n"
  fi
done <<< "$DISK_USAGE"

# Optionally print the message
echo -e "$message"
