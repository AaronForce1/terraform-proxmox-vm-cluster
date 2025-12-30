terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 2.9"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "proxmox" {
  pm_tls_insecure        = true
  pm_parallel            = 20
  pm_api_url             = var.proxmox_url
  pm_api_token_id        = var.proxmox_token_id
  pm_api_token_secret    = var.proxmox_token
}

