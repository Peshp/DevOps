terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.89.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tonyresource_group" {
  name     = "tonyrg"
  location = "West Europe"
}