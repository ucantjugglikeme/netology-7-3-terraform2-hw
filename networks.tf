resource "yandex_vpc_network" "test_net" {
  name = "test-vpc"
}

resource "yandex_vpc_subnet" "test_subnet_a" {
  name           = "test-subnet-a"
  network_id     = yandex_vpc_network.test_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  zone           = "ru-central1-a"
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "test_subnet_d" {
  name           = "test-subnet-d"
  network_id     = yandex_vpc_network.test_net.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  zone           = "ru-central1-d"
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gw" {
  name = "test-nat-gw"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-rt"
  network_id = yandex_vpc_network.test_net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gw.id
  }
}

resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "bastion-sg"
  network_id  = yandex_vpc_network.test_net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "local_sg" {
  name        = "local-sg"
  network_id  = yandex_vpc_network.test_net.id

  ingress {
    protocol       = "Any"
    description    = "Allow 10.0.0.0/8"
    v4_cidr_blocks = ["10.0.0.0/8"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-sg"
  network_id  = yandex_vpc_network.test_net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}

resource "yandex_vpc_security_group" "db_sg" {
  name        = "db-sg"
  network_id  = yandex_vpc_network.test_net.id

  ingress {
    protocol          = "TCP"
    description       = "Allow PostgreSQL from Web Servers"
    security_group_id = yandex_vpc_security_group.web_sg.id
    port              = 5432
  }
}
