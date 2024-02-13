#!/bin/bash
IP_FILE="public_ips.txt"
while IFS= read -r ip; do
    echo "Executing command on $ip"
	ssh   azureuser@$ip "docker run -itd --name tomcat-container acrnoaman.azurecr.io/abha:${{ github.run_number }}-DEV" 
done < "$IP_FILE"
