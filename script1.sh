#!/bin/bash

CSV_FILE="ip_path.csv"

mapfile -t lines < "$CSV_FILE"

for line in "${lines[@]}"; do
    if [[ "$line" == "IP,Path" ]]; then
        continue
    fi
    
    IFS=',' read -r IP Path <<< "$line"
    IP=$(echo "$IP" | xargs)
    Path=$(echo "$Path" | xargs)
    App=$(echo "$App" | xargs)
    echo "Connecting to $IP and going to $Path"
    
ssh root@$IP << EOF
    cd "$Path" || exit
    rm -rf *.jar libs
    cd ../BACKUP || exit
    cp $App.tar.gz "$Path"
    cd "$Path" || exit
    tar -xvf *.tar.gz
    rm -rf *.tar.gz
EOF

done


