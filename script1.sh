#!/bin/bash

CSV_FILE="temp_servers.csv"

mapfile -t lines < "$CSV_FILE"

for line in "${lines[@]}"; do
    if [[ "$line" == "IP,Path" ]]; then
        continue
    fi
    
    IFS=',' read -r IP Path <<< "$line"
    IP=$(echo "$IP" | xargs)
    Path=$(echo "$Path" | xargs)
    
    echo "Connecting to $IP and going to $Path"
    
     ssh root@$IP "cd $Path && git init && git remote add origin https://github.com/manali0804/reactapp.git && git pull " >/dev/null 2>&1

done


