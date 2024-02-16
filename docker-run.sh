#!/bin/bash
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
               ssh azureuser@$ip 'sudo apt update; sudo apt-get install -y azure-cli; sudo apt install default-jre -y; sudo apt install apt-transport-https ca-certificates curl software-properties-common -y; curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y;  sudo apt install docker-ce -y'

done < ""$file_path""

echo "Script execution completed."
