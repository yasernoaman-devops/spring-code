#!/bin/bash

# File containing IP addresses
ip_file="terrform-code/public_ips.txt"
GH_RUN_NUMBER=$(echo "${GITHUB_RUN_NUMBER}" | tr -d -)
# Read each line from the file
while IFS= read -r ip_address; do
    echo "Connecting to $ip_address..."

    # SSH into the remote server and execute commands
    ssh azureuser@$ip_address <<'EOF'
        # Commands to be executed on the remote server
        echo "Executing commands on $HOSTNAME"
        sudo  az acr login --name ACRNOAMAN --username ACRNOAMAN --password BvZYFM64ATh/HjrSJm6mAMk0/qM9PVLvMhss2TeuSM+ACRDF7GJU
        sudo  docker pull acrnoaman.azurecr.io/abha:"$GH_RUN_NUMBER"-DEV
		sudo docker run -it -p 80:8080 acrnoaman.azurecr.io/abha:"$GH_RUN_NUMBER"-DEV


EOF

    # Check the exit status of the SSH command
    if [ $? -eq 0 ]; then
        echo "Successfully executed commands on $ip_address"
    else
        echo "Error: Failed to execute commands on $ip_address"
    fi

done < "$ip_file"
