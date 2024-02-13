#!/bin/bash
while IFS= read -r ip; do
    echo "Executing commands on $ip"
    'ssh-keygen -f "/home/azureuser/.ssh/known_hosts" -R "$ip"; ssh -o "StrictHostKeyChecking=no" $ip'
done < "$1"	
echo "Script execution completed."
