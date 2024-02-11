


data "azurerm_virtual_network" "vnet-1" {
  name                = "VNET-B"
  resource_group_name = "PRACTICE-RG"
}

data azurerm_subnet "subnet-1" {
  name                 = "SUBNET-B"
  virtual_network_name = "VNET-B"
  resource_group_name  = "PRACTICE-RG"
}


# Public IP
resource "azurerm_public_ip" "main-public-ip" {
  count                = var.vm_count
  name                 = "${var.vm_prefix}-publicip-${count.index}"
  resource_group_name  = "PRACTICE-RG"
  location            = var.location-1
  allocation_method   = "Static"
}


# Network Interface
resource "azurerm_network_interface" "main-network-interface" {
  count               = var.vm_count
  name                = "${var.vm_prefix}-nic-${count.index}"
  resource_group_name = "PRACTICE-RG"
  location = var.location-1
  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main-public-ip[count.index].id
  }
}


#########

resource "azurerm_network_security_group" "poc-sg" {
  name                = "poc-sg"
  location            = var.location-1
  resource_group_name = "PRACTICE-RG"

  security_rule {
    name                       = "AllowSSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 315
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "poc-sg-link" {  
  subnet_id                 = data.azurerm_subnet.subnet-1.id
  network_security_group_id = azurerm_network_security_group.poc-sg.id

  depends_on = [
    azurerm_network_security_group.poc-sg
  ]
}

###########


