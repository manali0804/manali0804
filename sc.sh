#!/bin/bash

ODS_FILE="ip_path.ods"
CSV_FILE="temp_servers.csv"

# Convert the ODS file to CSV using ssconvert
ssconvert "$ODS_FILE" "$CSV_FILE"

# Read the CSV file line by line, skipping the header
while IFS=$'\t' read -r IP Path; do
    # Skip the header line
    if [[ "$IP" == "ip" ]]; then
        continue
    fi

    # Trim any leading or trailing whitespace
    IP=$(echo "$IP" | xargs)
    Path=$(echo "$Path" | xargs)

    # Ensure Path starts with a slash
    if [[ "$Path" != /* ]]; then
        Path="/$Path"
    fi
    
    # Connect via SSH and create the directory
    ssh root@$IP "cd $Path && mkdir -p manali1" >/dev/null 2>&1

done < "$CSV_FILE"  # Redirect input to the while loop

# Clean up the temporary CSV file
rm "$CSV_FILE"

