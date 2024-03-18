# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
    required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}

#Key ssh
resource "tls_private_key" "my_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg" {
    name     =  "fgg_kubernetes_rg"
    location = var.location

    tags = {
        environment = "casopractico2"
    }

}

# Storage account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "stAccount" {
    name                     = "stgcp2fgg" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "casopractico2"
    }

}

#Creación de ACR
resource "azurerm_container_registry" "myAcr" {
  name                     = "myAcrfgg"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Standard"
  admin_enabled            = true
  public_network_access_enabled = true
  
    tags = {
        environment = "casopractico2"
    }
}

