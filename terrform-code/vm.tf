resource "azurerm_linux_virtual_machine" "linuxvm" {
        count  = var.vm_count
        name   = "${var.vm_prefix}-${count.index}"
        size = "Standard_DS12_v2"
        network_interface_ids = [azurerm_network_interface.main-network-interface[count.index].id]
        disable_password_authentication = "true"
        resource_group_name = "PRACTICE-RG"
        admin_username        = "azureuser"
        location = var.location-1
        admin_ssh_key {
          username   = "azureuser"
          public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key
        }
        os_disk {
            name              = "myOsDisk-${count.index}"
            caching           = "ReadWrite"
            storage_account_type = "Standard_LRS"
        }
        source_image_reference {
           publisher = "Canonical"
           offer     = "0001-com-ubuntu-server-jammy"
           sku       = "22_04-lts"
           version   = "latest"
                }
        provisioner "local-exec" {
              command = "echo ${azurerm_public_ip.main-public-ip[count.index].ip_address} >> public_ips.txt"
  }
}

output "instance_names" {
  value = {
    for ips in range(var.vm_count) :
    ips => azurerm_linux_virtual_machine.linuxvm[ips].name
  }
}
