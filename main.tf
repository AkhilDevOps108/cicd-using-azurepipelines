terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# small random suffix for storage account naming rules
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  number  = true
}

module "rg" {
  source   = "./modules/rg"
  name     = var.rg_name
  location = var.location
}

module "storage" {
  source = "./modules/storage"
  name   = lower("${var.storage_prefix}${random_string.suffix.result}")
  location = var.location
  resource_group_name = module.rg.name
}
