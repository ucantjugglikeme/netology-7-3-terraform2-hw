data "yandex_compute_image" "ubuntu_24_lts" {
  family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "bastion_vm" {
  name        = "bastion-vm1"
  hostname    = "bastion-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_24_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.test_subnet_d.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id, yandex_vpc_security_group.local_sg.id]
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }
}

resource "yandex_compute_instance" "web_d" {
  name        = "web-d"
  hostname    = "web-d"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

   resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_24_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.test_subnet_d.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.local_sg.id, yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }
}

resource "yandex_compute_instance" "web_a" {
  name        = "web-a"
  hostname    = "web-a"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

   resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_24_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.test_subnet_a.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.local_sg.id, yandex_vpc_security_group.web_sg.id]
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }
}

resource "local_file" "inventory" {
  content = <<-XYZ
  [bastion]
  ${yandex_compute_instance.bastion_vm.network_interface.0.nat_ip_address}

  [webservers]
  ${yandex_compute_instance.web_a.network_interface.0.ip_address}
  ${yandex_compute_instance.web_d.network_interface.0.ip_address}
  [webservers:vars]
  ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q user@${yandex_compute_instance.bastion_vm.network_interface.0.nat_ip_address}"'
  XYZ
  filename = "./inventories/production/hosts.ini"
}
