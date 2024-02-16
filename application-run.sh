#!/bin/bash
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
               ssh azureuser@$ip 'sudo docker login -u ACRNOAMAN -p BvZYFM64ATh/HjrSJm6mAMk0/qM9PVLvMhss2TeuSM+ACRDF7GJU  acrnoaman.azurecr.io; sudo docker pull acrnoaman.azurecr.io/abha:${{ github.run_number }}-DEV; sudo docker run -itd --name demo-container -p 80:8080 acrnoaman.azurecr.io/abha:${{ github.run_number }}-DEV'

done < ""$file_path""

echo "Script execution completed."
