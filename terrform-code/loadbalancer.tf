resource "azurerm_public_ip" "loadbalancer-public-ip" {
  name                = "loadbalancer-public-ip"
  resource_group_name = "PRACTICE-RG"
  location            = var.location-1
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "loadbalancer" {
  name                = "load-balancer"
  location            = var.location-1
  resource_group_name = "PRACTICE-RG"
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.loadbalancer-public-ip.id
  }
  depends_on = [
    azurerm_public_ip.loadbalancer-public-ip
  ]
}

resource "azurerm_lb_backend_address_pool" "POC-POOL" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "POC-POOL"
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_backend_address_pool_address" "appvmaddress" {
  count=var.vm_count  
  name                    = "appvm${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.POC-POOL.id
  virtual_network_id      = data.azurerm_virtual_network.vnet-1.id
  ip_address              = azurerm_network_interface.main-network-interface[count.index].private_ip_address
  depends_on = [
    azurerm_lb_backend_address_pool.POC-POOL,
    azurerm_network_interface.main-network-interface
  ]
}

resource "azurerm_lb_probe" "POC_PROBE" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "POC_PROBE"
  port            = 80
  protocol = "Tcp"
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_rule" "POC-RULE-A" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "POC-RULE-A"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  probe_id = azurerm_lb_probe.POC_PROBE.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.POC-POOL.id]
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

