![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

# terraform-proxmox-vm-cluster

[![Terraform Version](https://img.shields.io/badge/Terraform%20Version-%3E=1.5-623CE4.svg)](https://github.com/hashicorp/terraform)

Terraform module built to integrate with PROXMOX On-Prem Hypervisor and deploy VMs with Cloud-Init based on an existing VM or Template. The cluster of vms are typically used to run kubernetes on-prem with kubespray.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.2-rc07 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.14 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/Telmate/proxmox/3.0.2-rc07/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_base_settings"></a> [proxmox\_base\_settings](#input\_proxmox\_base\_settings) | Base Proxmox VM Provisioning Settings; Can be used to set common settings across multiple VMs | <pre>object({<br/>    proxmox_clone = string<br/>    target_node   = string<br/>    disk_configuration = list(object({<br/>      type    = string<br/>      storage = string<br/>      size    = string<br/>      slot    = string<br/>    }))<br/>    network_configuration = list(object({<br/>      id     = number<br/>      model  = string<br/>      bridge = string<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_proxmox_defaults"></a> [proxmox\_defaults](#input\_proxmox\_defaults) | Core Default Proxmox Configurations for Simplicity of Deployment | <pre>object({<br/>    cores   = number<br/>    sockets = number<br/>    memory  = number<br/>    hotplug = string<br/>    ostype  = string<br/>    os      = string<br/>    bios    = string<br/>  })</pre> | <pre>{<br/>  "bios": "SeaBIOS",<br/>  "cores": 2,<br/>  "hotplug": "network,disk,cpu",<br/>  "memory": 2048,<br/>  "os": "ubuntu",<br/>  "ostype": "cloud-init",<br/>  "sockets": 1<br/>}</pre> | no |
| <a name="input_proxmox_ssh"></a> [proxmox\_ssh](#input\_proxmox\_ssh) | SSH Keys to provision on the VM | `string` | `""` | no |
| <a name="input_proxmox_vms"></a> [proxmox\_vms](#input\_proxmox\_vms) | Proxmox VMs to be provisioned | <pre>list(object({<br/>    name           = string<br/>    id             = number<br/>    ipconfig       = string<br/>    target_node    = optional(string)<br/>    clone_override = optional(bool)<br/>    full_clone     = optional(bool)<br/>    ostype         = optional(string)<br/>    os             = optional(string)<br/>    cores          = optional(number)<br/>    sockets        = optional(number)<br/>    memory         = optional(number)<br/>    hotplug        = optional(string)<br/>    scsihw         = optional(string)<br/>    sshkeys        = optional(string)<br/>    network_configuration = optional(list(object({<br/>      model  = string<br/>      bridge = string<br/>    })))<br/>    disk_configuration = optional(list(object({<br/>      type    = string<br/>      storage = string<br/>      size    = string<br/>      slot    = string<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
