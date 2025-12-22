resource "proxmox_vm_qemu" "vm" {
  for_each = {
    for vm in var.proxmox_vms : vm.name => vm
  }
  vmid = each.value.id
  name = each.value.name
  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = coalesce(each.value.target_node, var.proxmox_defaults.target_node)

  cpu {
    type    = "x86-64-v2-AES"
    cores   = coalesce(each.value.cores, var.proxmox_defaults.cores)
    sockets = coalesce(each.value.sockets, var.proxmox_defaults.sockets)
  }
  memory  = coalesce(each.value.memory, var.proxmox_defaults.memory)
  scsihw = coalesce(each.value.scsihw, "virtio-scsi-single")
  boot = "order=scsi0" # has to be the same as the OS disk of the template

  # The template name to clone this vm from
  clone      = coalesce(each.value.clone_override, var.proxmox_defaults.proxmox_clone)
  full_clone = true

  automatic_reboot = true

  ## With preprovision, you can provision a VM directly from the resource block. 
  ## This provisioning method is therefore ran ** before** provision blocks.
  ## When using preprovision, there are three os_type options: ubuntu, centos or cloud-init.
  os_type   = "cloud-init"
  # cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciuser    = coalesce(each.value.os, var.proxmox_defaults.os)
  ciupgrade = true
  ## Resource Configuration
  hotplug = coalesce(each.value.hotplug, var.proxmox_defaults.hotplug)

  sshkeys = coalesce(each.value.sshkeys, var.proxmox_ssh)
  
  # Setup the disk
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "local-zfs"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size = "80G"
          storage = "local-zfs"
        }
      }
    }
  }

  dynamic "network" {
    for_each = {
      for index, net in coalesce(each.value.network_configuration, var.proxmox_defaults.network_configuration) : "network.${index}" => {
        id     = index
        model  = net.model
        bridge = net.bridge
      }
    }
    content {
      id     = network.value.id
      model  = network.value.model
      bridge = network.value.bridge
    }
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = each.value.ipconfig
}
