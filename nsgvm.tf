resource "azurerm_network_security_group" "this_vm_nsg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name 
}

resource "azurerm_network_security_rule" "this_vm_network_security_rule" {
  name                        = "${loacal.owner}-${loacal.environment}-${var.vm_network_security_rule_name}" 
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_vm_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "this_vm_nsg_association" {
  subnet_id                 = azurerm_subnet.this_subnet.id
  network_security_group_id = azurerm_network_security_group.this_vm_nsg.id
}