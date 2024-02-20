#!/bin/bash

# File containing IP addresses
ip_file="terrform-code/public_ips.txt"
# Read each line from the file
while IFS= read -r ip_address; do
    echo "Connecting to $ip_address..."

    # SSH into the remote server and execute commands
    ssh azureuser@$ip_address <<'EOF'
        GH_RUN_NUMBER=$(echo "${GITHUB_RUN_NUMBER}" | tr -d -)
        # Commands to be executed on the remote server
        echo "Executing commands on $HOSTNAME"
        sudo az acr login --name HACIAC --username HACIAC --password /bfp1M4tMSg5BXNdXC6WwGar7ecj+9m0E/87OQmNz9+ACRBQuFOH
        sudo docker pull haciac.azurecr.io/hce:$GH_RUN_NUMBER-DEV
        sudo docker run -itd -p 80:8080 haciac.azurecr.io/hce:$GH_RUN_NUMBER-DEV


EOF

    # Check the exit status of the SSH command
    if [ $? -eq 0 ]; then
        echo "Successfully executed commands on $ip_address"
    else
        echo "Error: Failed to execute commands on $ip_address"
    fi

done < "$ip_file"
