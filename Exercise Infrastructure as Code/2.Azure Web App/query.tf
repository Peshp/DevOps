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

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "cbrg" {
  name     = "contact_book_rg-${random_integer.ri.result}"
  location = "West Europe"
}

resource "azurerm_service_plan" "asp" {
  name                = "contact-book-service-plan${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.cbrg.name
  location            = azurerm_resource_group.cbrg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "alwp" {
  name                = "contactBookWebApp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.cbrg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = "16-lts"
    }
    always_on = false
  }
}

resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.alwp.id
  repo_url               = "https://github.com/nakov/ContactBook"
  branch                 = "master"
  use_manual_integration = true
}

