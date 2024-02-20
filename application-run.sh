#!/bin/bash
ip_file="terrform-code/public_ips.txt"
while IFS= read -r ip_address; do
    echo "Connecting to $ip_address..."
    GH_RUN_NUMBER=$(echo "${GITHUB_RUN_NUMBER}" | tr -d -)
    ssh azureuser@$ip_address <<EOF
        echo $GH_RUN_NUMBER
        echo "Executing commands on $HOSTNAME"
        sudo az acr login --name HACIAC --username HACIAC --password /bfp1M4tMSg5BXNdXC6WwGar7ecj+9m0E/87OQmNz9+ACRBQuFOH
        sudo docker pull haciac.azurecr.io/hce:$GH_RUN_NUMBER-DEV
        sudo docker run -itd -p 80:8080 haciac.azurecr.io/hce:$GH_RUN_NUMBER-DEV


EOF
    if [ $? -eq 0 ]; then
        echo "Successfully executed commands on $ip_address"
    else
        echo "Error: Failed to execute commands on $ip_address"
    fi

done < "$ip_file"
