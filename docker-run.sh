#!/bin/bash
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
               ssh azureuser@$ip 'sudo apt update; curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null; sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list'; sudo apt update; sudo apt install -y azure-cli; sudo apt install default-jre -y; sudo apt install apt-transport-https ca-certificates curl software-properties-common -y; curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y;  sudo apt install docker-ce -y'

done < ""$file_path""

echo "Script execution completed."
