#!/bin/bash
while IFS= read -r ip; do
    echo "Executing commands on $ip"
               ssh azureuser@$ip 'docker run -itd --name tomcat-container acrnoaman.azurecr.io/abha:${{ github.run_number }}-DEV'

done < "$1"

echo "Script execution completed."
