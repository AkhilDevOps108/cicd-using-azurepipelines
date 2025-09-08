# Core infra inputs
variable "rg_name" {
  type    = string
  default = "demo-rg-tf"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "storage_prefix" {
  type    = string
  default = "demostg"
}

# Optional provider auth variables (leave empty to use Azure CLI auth / service connection)
variable "tenant_id" {
  type    = string
  default = ""
  description = "Azure tenant id. Leave empty to use Azure CLI auth (recommended in pipelines with service connection)."
}

variable "subscription_id" {
  type    = string
  default = ""
  description = "Azure subscription id. Leave empty to use Azure CLI auth."
}

variable "client_id" {
  type    = string
  default = ""
  description = "Service Principal client id. Leave empty to use Azure CLI auth."
}

variable "client_secret" {
  type    = string
  default = ""
  description = "Service Principal client secret. Leave empty to use Azure CLI auth."
  sensitive = true
}
