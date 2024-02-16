#!/bin/bash

# Replace these values with your ACR credentials
ACR_NAME="ACRNOAMAN"
ACR_USERNAME="ACRNOAMAN"
ACR_PASSWORD="BvZYFM64ATh/HjrSJm6mAMk0/qM9PVLvMhss2TeuSM+ACRDF7GJU"

# Replace this with the path to your test file containing IP addresses
TEST_FILE="terrform-code/public_ips.txt"

# Replace this with the desired image name
IMAGE_NAME="abha"

# Get GitHub run number as the image tag
GITHUB_RUN_NUMBER=$1

# Log in to ACR


# Iterate over IP addresses from the test file
while IFS= read -r IP_ADDRESS; do
    echo "Processing $IP_ADDRESS"
    ssh azureuser@$IP_ADDRESS 'az acr login --name $ACR_NAME --username $ACR_USERNAME --password $ACR_PASSWORD; docker pull $ACR_NAME.azurecr.io/$IMAGE_NAME:$GITHUB_RUN_NUMBER-DEV'
    # Run other commands or operations as needed for each IP address
    # For example, you can deploy the pulled image to the specified IP address

done < "$TEST_FILE"

# Logout from ACR
az acr logout
