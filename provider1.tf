terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "InvenicsDevOps-rg"
    storage_account_name = "devopsterraform"
    container_name       = "statefile"
    key                 = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  region = "centralindia"
}