variable "proxmox_url" {
  description = "The Proxmox VE API URL"
  type        = string
}

variable "proxmox_token_id" {
  description = "The Proxmox VE API token ID"
  type        = string
}

variable "proxmox_token" {
  description = "The Proxmox VE API token secret"
  type        = string
}

variable "proxmox_target_node" {
  description = "The Proxmox VE target node for the VM"
  type        = string
}

variable "proxmox_local_storage" {
  description = "The Proxmox VE local storage for VM disks"
  type        = string
}

variable "proxmox_clone_template" {
  description = "The Proxmox VE template to clone VMs from"
  type        = string
}