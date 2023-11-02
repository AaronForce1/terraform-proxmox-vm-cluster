# ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) <br/> terraform-proxmox-vm-cluster

[![Terraform Version](https://img.shields.io/badge/Terraform%20Version-%3E=1.5-623CE4.svg)](https://github.com/hashicorp/terraform)

Terraform module built to integrate with PROXMOX On-Prem Hypervisor and deploy VMs with Cloud-Init based on an existing VM or Template. The cluster of vms are typically used to run kubernetes on-prem with kubespray.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~>2.9 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.14 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu) | resource |
| [random_integer.vm-id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_defaults"></a> [proxmox\_defaults](#input\_proxmox\_defaults) | Default Proxmox Configurations for Simplicity of Deployment | <pre>object({<br>    cores         = number<br>    sockets       = number<br>    memory        = number<br>    hotplug       = string<br>    proxmox_clone = string<br>    disk_configuration = list(object({<br>      type    = string<br>      storage = string<br>      size    = string<br>    }))<br>    network_configuration = list(object({<br>      model  = string<br>      bridge = string<br>    }))<br>    os          = string<br>    target_node = string<br>  })</pre> | <pre>{<br>  "cores": 1,<br>  "disk_configuration": [<br>    {<br>      "size": "50G",<br>      "storage": "local-btrfs",<br>      "type": "virtio"<br>    }<br>  ],<br>  "hotplug": "network,disk,cpu,memory",<br>  "memory": 2048,<br>  "network_configuration": [<br>    {<br>      "bridge": "vmbr0",<br>      "model": "virtio"<br>    }<br>  ],<br>  "os": "debian",<br>  "proxmox_clone": "debian-12-infra-compute-template",<br>  "sockets": 1,<br>  "target_node": "compute-1"<br>}</pre> | no |
| <a name="input_proxmox_ssh"></a> [proxmox\_ssh](#input\_proxmox\_ssh) | SSH Keys to provision on the VM | `string` | `""` | no |
| <a name="input_proxmox_vms"></a> [proxmox\_vms](#input\_proxmox\_vms) | Proxmox VMs to be provisioned | <pre>list(object({<br>    name           = string<br>    id             = number<br>    ipconfig       = string<br>    target_node    = optional(string)<br>    clone_override = optional(bool)<br>    full_clone     = optional(bool)<br>    os             = optional(string)<br>    cores          = optional(number)<br>    sockets        = optional(number)<br>    memory         = optional(number)<br>    hotplug        = optional(string)<br>    scsihw         = optional(string)<br>    sshkeys        = optional(string)<br>    network_configuration = list(object({<br>      model  = string<br>      bridge = string<br>    }))<br>    disk_configuration = list(object({<br>      type    = string<br>      storage = string<br>      size    = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
