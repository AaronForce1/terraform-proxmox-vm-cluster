resource "proxmox_vm_qemu" "vm" {
  for_each = {
    for vm in var.proxmox_vms : vm.name => vm
  }

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = coalesce(each.value.target_node, var.proxmox_defaults.target_node)

  # The template name to clone this vm from
  clone      = coalesce(each.value.clone_override, var.proxmox_defaults.proxmox_clone)
  full_clone = coalesce(each.value.full_clone, true)

  vmid = coalesce(each.value.id, random_integer.vm-id.result)

  name = each.value.name

  ## With preprovision, you can provision a VM directly from the resource block. 
  ## This provisioning method is therefore ran ** before** provision blocks.
  ## When using preprovision, there are three os_type options: ubuntu, centos or cloud-init.
  os_type = "cloud-init"
  ciuser  = coalesce(each.value.os, var.proxmox_defaults.os)

  ## Resource Configuration
  cores   = coalesce(each.value.cores, var.proxmox_defaults.cores)
  sockets = coalesce(each.value.sockets, var.proxmox_defaults.sockets)
  memory  = coalesce(each.value.memory, var.proxmox_defaults.memory)
  hotplug = coalesce(each.value.hotplug, var.proxmox_defaults.hotplug)


  boot = "c"
  bios = coalesce(each.value.bios, var.proxmox_defaults.bios, "seabios")

  sshkeys = coalesce(each.value.sshkeys, var.proxmox_ssh)

  scsihw = coalesce(each.value.scsihw, "virtio-scsi-single")

  # Setup the disk
  dynamic "disk" {
    for_each = coalesce(each.value.disk_configuration, var.proxmox_defaults.disk_configuration)
    content {
      size    = each.value.size
      type    = each.value.type
      storage = each.value.storage
    }
  }

  dynamic "network" {
    for_each = coalesce(each.value.network_configuration, var.proxmox_defaults.network_configuration)
    content {
      model  = each.value.model
      bridge = each.value.bridge
    }
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = each.value.ipconfig
}

resource "random_integer" "vm-id" {
  min = 90000
  max = 100000
}
