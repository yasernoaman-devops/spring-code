#!/bin/bash
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
               ssh azureuser@$ip 'yum install java -y; yum install docker -y; docker run -itd --name tomcat-container acrnoaman.azurecr.io/abha:${{ github.run_number }}-DEV'

done < ""$file_path""

echo "Script execution completed."
