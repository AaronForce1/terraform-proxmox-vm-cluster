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
    os             = optional(string)
    cores          = optional(number)
    sockets        = optional(number)
    memory         = optional(number)
    hotplug        = optional(string)
    scsihw         = optional(string)
    sshkeys        = optional(string)
    bios           = optional(string)
    network_configuration = list(object({
      model  = string
      bridge = string
    }))
    disk_configuration = list(object({
      type    = string
      storage = string
      size    = string
    }))
  }))
  default = []
}

## TODO: Remove default choices; require user to configure all options
variable "proxmox_defaults" {
  description = "Default Proxmox Configurations for Simplicity of Deployment"
  type = object({
    cores         = number
    sockets       = number
    memory        = number
    hotplug       = string
    proxmox_clone = string
    disk_configuration = object({
      scsi    = optional(map(object({
        type    = string
        storage = string
        size    = string
      })))
    })
    network_configuration = list(object({
      model  = string
      bridge = string
    }))
    os          = string
    target_node = string
    bios = string
  })
  default = {
    cores         = 1
    sockets       = 1
    memory        = 2048
    hotplug       = "network,disk,cpu,memory"
    proxmox_clone = "debian-12-infra-compute-template"
    disk_configuration = {
      scsi = {
        scsi0 = {
          type = "virtio"
          storage = "at-hk-compute-1"
          size = "40G"
        }
      }
    }
    network_configuration = [
      {
        model  = "virtio"
        bridge = "vmbr0"
      }
    ]
    os          = "debian"
    target_node = "compute-1"
    bios = "seabios"
  }
}

variable "proxmox_ssh" {
  description = "SSH Keys to provision on the VM"
  type        = string
  default     = ""
}