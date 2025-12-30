module "vm_cluster" {
  source = "../.."

   proxmox_vms = [
    {
      name            = "vm-example-0"
      id              = 999999
      ipconfig        = "ip=192.168.0.10/24,gw=192.168.0.1"
    }
  ]

  proxmox_base_settings = {
    proxmox_clone = var.proxmox_clone_template
    target_node = var.proxmox_target_node
    disk_configuration = [
      {
        type    = "cloudinit"
        storage = var.proxmox_local_storage
        size    = "4G"
        slot    = "ide0"
      },
      {
        type    = "ignore"
        storage = var.proxmox_local_storage
        size    = "40G"
        slot    = "scsi0"
      }
    ]
    network_configuration = [
      {
        id     = 0
        model = "virtio"
        bridge = "vmbr0"
      }
    ]
  }

  proxmox_defaults = {
    cores = 4
    sockets = 1
    memory = 32768
    hotplug =  "network,disk,cpu"
    
    ostype = "cloud-init"
    os = "debian"
    bios = "SeaBIOS"
  }
}