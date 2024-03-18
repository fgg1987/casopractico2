resource "azurerm_linux_virtual_machine" "myVM" {
  name                              = "myVMubuntu"
  location                          = azurerm_resource_group.rg.location
  resource_group_name               = azurerm_resource_group.rg.name
  network_interface_ids             = [azurerm_network_interface.myNic1.id]
  size                              = var.vm_size
  admin_username                    = "adminUsername"
  disable_password_authentication   = true

  admin_ssh_key {
    username   = "adminUsername"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer                 = "0001-com-ubuntu-server-jammy"
    publisher             = "Canonical"
    sku                   = "22_04-lts-gen2"
    version               = "latest"
  }
  
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "casopractico2"
    }
}

