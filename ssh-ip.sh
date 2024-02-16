#!/bin/bash
sleep 3m
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
   ssh-copy-id -o StrictHostKeyChecking=no azureuser@$ip
done < "$file_path"
echo "Script execution completed."

