############

resource "azurerm_virtual_machine" "linuxvm" {
        count  = var.vm_count
        name   = "${var.vm_prefix}-${count.index}"
        vm_size = "Standard_DS12_v2"
        network_interface_ids = [azurerm_network_interface.main-network-interface[count.index].id]
        delete_data_disks_on_termination = "true"
        delete_os_disk_on_termination = "true"
        resource_group_name = "PRACTICE-RG"
        location = var.location-1
        storage_os_disk {
            name              = "myOsDisk-${count.index}"
            caching           = "ReadWrite"
            create_option     = "FromImage"
            managed_disk_type = "Standard_LRS"
        }
        os_profile_linux_config {
            disable_password_authentication = true
            ssh_keys {
            path     = "/home/abdmuser/.ssh/authorized_keys"
            key_data = "/home/abdmuser/.ssh/id_rsa.pub"
            }
        }   
        storage_image_reference {
              id =  "/subscriptions/dc60d2a6-ae24-4960-a488-f53a8643a853/resourceGroups/PRACTICE-RG/providers/Microsoft.Compute/galleries/yaser/images/honeywell"
        }

        provisioner "local-exec" {
              command = "echo ${azurerm_public_ip.main-public-ip[count.index].ip_address} >> public_ips.txt"
  }          
}


###########


