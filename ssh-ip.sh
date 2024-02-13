#!/bin/bash
IP_FILE="public_ips.txt"
while IFS= read -r ip; do
    echo "Executing command on $ip"
	
    ssh-keygen -f "/home/azureuser/.ssh/known_hosts" -R "$ip"
	ssh -o "StrictHostKeyChecking=no" $ip" 
done < "$IP_FILE"
