# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "3b65aa4a-6333-4cf8-9b7d-b41e3df810cb"
  client_id = "7eb1caa7-924d-4d20-aad8-c3dc26bb7132"
  tenant_id = "65582760-3ca3-49d9-91d7-f2fd6402bb4e"
  client_secret = "4zD8Q~~Wd~FqRxkqmQ4m4s5BVBIhg0oW48pcWaZX"

}


# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["${var.vnet_address}"]

subnet {
    name           = "subnet1"
    address_prefix = "${var.subnet1}"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }

}

resource "azurerm_app_service_plan" "AppSP" {
  name                = "${var.appservice}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "AppWeb" {
  name                = "${var}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.AppSP.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

}