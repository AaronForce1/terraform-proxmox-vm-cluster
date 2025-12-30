## TODO: Match a variable object to the proxmox_defaults for better management and customisability
variable "proxmox_vms" {
  description = "Proxmox VMs to be provisioned"
  type = list(object({
    name           = string
    id             = number
    ipconfig       = string
    target_node    = optional(string)
    clone_override = optional(bool)
    full_clone     = optional(bool)
    ostype         = optional(string)
    os             = optional(string)
    cores          = optional(number)
    sockets        = optional(number)
    memory         = optional(number)
    hotplug        = optional(string)
    scsihw         = optional(string)
    sshkeys        = optional(string)
    network_configuration = optional(list(object({
      model  = string
      bridge = string
    })))
    disk_configuration = optional(list(object({
      type    = string
      storage = string
      size    = string
      slot    = string
    })))
  }))
  default = []
}

variable "proxmox_base_settings" {
  description = "Base Proxmox VM Provisioning Settings; Can be used to set common settings across multiple VMs"
  type = object({
    proxmox_clone = string
    target_node   = string
    disk_configuration = list(object({
      type    = string
      storage = string
      size    = string
      slot    = string
    }))
    network_configuration = list(object({
      id     = number
      model  = string
      bridge = string
    }))
  })
}

## TODO: Remove default choices; require user to configure all options
variable "proxmox_defaults" {
  description = "Core Default Proxmox Configurations for Simplicity of Deployment"
  type = object({
    cores   = number
    sockets = number
    memory  = number
    hotplug = string
    ostype  = string
    os      = string
    bios    = string
  })
  default = {
    cores   = 2
    sockets = 1
    memory  = 2048
    hotplug = "network,disk,cpu"
    ostype  = "cloud-init"
    os      = "ubuntu"
    bios    = "SeaBIOS"
  }
}

variable "proxmox_ssh" {
  description = "SSH Keys to provision on the VM"
  type        = string
  default     = ""
}
