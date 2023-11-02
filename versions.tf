terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~>2.9"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.5"
}
