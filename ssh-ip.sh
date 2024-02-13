
#!/bin/bash
file_path="terrform-code/public_ips.txt"
while IFS= read -r ip; do
    echo "Executing commands on $ip"
    'ssh-keygen -f "/home/azureuser/.ssh/known_hosts" -R "$ip"; ssh -o "StrictHostKeyChecking=no" $ip'
done < "$file_path"	
echo "Script execution completed."
