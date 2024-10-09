#!/bin/bash

EXCEL_FILE="ip_path.ods"
CSV_FILE="temp_servers.csv"

ssconvert "$EXCEL_FILE" "$CSV_FILE"

read -r FIRST_ROW < "$CSV_FILE"

IFS=',' read -r IP Path <<< "$FIRST_ROW"

echo "Connecting to $IP"

ssh root@$IP "cd $Path && mkdir manali1"  

rm "$CSV_FILE"
