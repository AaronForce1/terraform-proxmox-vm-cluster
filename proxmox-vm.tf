resource "proxmox_vm_qemu" "vm" {
  for_each = {
    for vm in var.proxmox_vms : vm.name => vm
  }

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = coalesce(each.value.target_node, var.proxmox_base_settings.target_node)

  # The template name to clone this vm from
  clone      = coalesce(each.value.clone_override, var.proxmox_base_settings.proxmox_clone)
  full_clone = coalesce(each.value.full_clone, true)

  vmid = each.value.id

  name = each.value.name

  ## With preprovision, you can provision a VM directly from the resource block.
  ## This provisioning method is therefore ran ** before** provision blocks.
  ## When using preprovision, there are three os_type options: ubuntu, centos or cloud-init.
  os_type = coalesce(each.value.ostype, var.proxmox_defaults.ostype)
  ciuser  = coalesce(each.value.os, var.proxmox_defaults.os)

  ## Resource Configuration
  cores   = coalesce(each.value.cores, var.proxmox_defaults.cores)
  sockets = coalesce(each.value.sockets, var.proxmox_defaults.sockets)
  memory  = coalesce(each.value.memory, var.proxmox_defaults.memory)
  hotplug = coalesce(each.value.hotplug, var.proxmox_defaults.hotplug)

  boot = "c"

  sshkeys = try(coalesce(each.value.sshkeys, var.proxmox_ssh), "")

  scsihw = coalesce(each.value.scsihw, "virtio-scsi-single")

  # Setup the disk
  dynamic "disk" {
    for_each = try(coalescelist(each.value.disk_configuration, var.proxmox_base_settings.disk_configuration), [])
    content {
      size    = disk.value.size
      type    = disk.value.type
      storage = disk.value.storage
      slot    = disk.value.slot
    }
  }

  dynamic "network" {
    for_each = toset(coalesce(each.value.network_configuration, var.proxmox_base_settings.network_configuration))
    content {
      id      = network.value.id
      model   = network.value.model
      bridge  = network.value.bridge
    }
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = each.value.ipconfig
}
