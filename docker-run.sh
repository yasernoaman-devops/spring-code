#!/bin/bash

# File containing IP addresses
ip_file="terrform-code/public_ips.txt"

# Read each line from the file
while IFS= read -r ip_address; do
    echo "Connecting to $ip_address..."

    # SSH into the remote server and execute commands
    ssh azureuser@$ip_address <<'EOF'
        # Commands to be executed on the remote server
          echo "Executing commands on $HOSTNAME"
          sudo  az acr login --name ACRNOAMAN --username ACRNOAMAN --password BvZYFM64ATh/HjrSJm6mAMk0/qM9PVLvMhss2TeuSM+ACRDF7GJU
          curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
          echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
          sudo apt update
          sudo apt install -y azure-cli
          sudo apt install default-jre -y
          sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
          curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
          sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
          sudo apt install docker-ce -y



EOF

    # Check the exit status of the SSH command
    if [ $? -eq 0 ]; then
        echo "Successfully executed commands on $ip_address"
    else
        echo "Error: Failed to execute commands on $ip_address"
    fi

done < "$ip_file"

