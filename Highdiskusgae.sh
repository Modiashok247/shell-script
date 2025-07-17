DISK_THRESHOLD=20
DISK_USAGE=$(df -Th | grep -vE 'tmpfs|Filesystem'| awk '{print $6," " $1}')
message=""

while IFS= read line;
do
  usage=$(echo $line | cut -d "%" -f1)
  partition=$(echo $DISK_USAGE | cut -d " " -f2)
  echo "usage: $usage"
  echo "partition: $partition"
 if [ $usage -ge $DISK_THRESHOLD ]
    then
        message+="High Disk usage on $partition:$usage%\n"
    fi
done <<< "$DISK_USAGE"