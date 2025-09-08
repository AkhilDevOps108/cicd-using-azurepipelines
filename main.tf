terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

# Provider config: tries env/var-based auth if provided, otherwise falls back to Azure CLI auth
provider "azurerm" {
  features {}

  # If variables are provided (non-empty), set them; otherwise pass null so Azure CLI auth can be used.
  tenant_id       = var.tenant_id != "" ? var.tenant_id : null
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
  client_id       = var.client_id != "" ? var.client_id : null
  client_secret   = var.client_secret != "" ? var.client_secret : null
}

provider "random" {}

# small random suffix for storage account naming rules
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

module "rg" {
  source   = "./modules/rg"
  name     = var.rg_name
  location = var.location
}

module "storage" {
  source              = "./modules/storage"
  name                = lower("${var.storage_prefix}${random_string.suffix.result}")
  location            = var.location
  resource_group_name = module.rg.name
}
