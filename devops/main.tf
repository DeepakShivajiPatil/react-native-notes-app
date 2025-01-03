terraform {
  required_providers {
    azurerm={
        source = "hasicorp/azurevm"
        version = "4.6.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Define variables
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "admin_username" {
  default = "azureuser"
}
variable "admin_password" {}
variable "vm_name" {
  default = "react-native-vm"
}
variable "location" {
  default = "East US"
}

# Use variables for provider authentication
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Resource group
resource "azurerm_resource_group" "main" {
  name     = "react-native-app-rg"
  location = var.location
}

# Virtual network
resource "azurerm_virtual_network" "main" {
  name                = "react-native-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subnet
resource "azurerm_subnet" "main" {
  name                 = "react-native-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network interface
resource "azurerm_network_interface" "main" {
  name                = "react-native-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  size                = "Standard_B1ls"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


#---------------------------------
# Below are the commands to execute the terraform file
    # terraform init
    # terraform plan -var-file="terraform.tfvars"

    # terraform apply -var-file="terraform.tfvars"

#---------------------------------