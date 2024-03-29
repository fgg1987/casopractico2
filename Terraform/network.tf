#Creacion de red
resource "azurerm_virtual_network" "myNet" {
  name                = "kubernetesnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
    tags = {
        environment = "casopractico2"
    }
}

#Creacion subred
resource "azurerm_subnet" "mySubnet" {
  name                 = "terraformsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myNet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Create NIC
resource "azurerm_network_interface" "myNic1" {
  name                = "vnic1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "myipconfigurantion1"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.myPublicIp1.id
  }
  
    tags = {
        environment = "casopractico2"
    }
}

#IP pública
resource "azurerm_public_ip" "myPublicIp1" {
     name                = "vmip1"
     location            = azurerm_resource_group.rg.location
     resource_group_name = azurerm_resource_group.rg.name
     allocation_method   = "Dynamic"
     sku                 = "Basic"
     
    tags = {
        environment = "casopractico2"
    }
}

