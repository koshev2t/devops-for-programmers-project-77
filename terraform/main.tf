resource "yandex_vpc_network" "vpc" {
  name = "yc-web-vpc"
}

# VPC Subnet within the VPC Network
resource "yandex_vpc_subnet" "subnet" {
  name           = "yc-web-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Virtual Machine instances
resource "yandex_compute_instance" "web" {
  count = 2

  name = "yc-web-server-${count.index}"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd82vchjp2kdjiuam29k"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.vm_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${var.admin_ssh_key}"
  }
}

resource "datadog_monitor" "healthcheck" {
  name    = "Healthcheck monitor"
  type    = "service check"
  query   = "\"http.can_connect\".over(\"instance:datadog_health_check\").by(\"host\",\"instance\",\"url\").last(4).count_by_status()"
  message = "{{host.name}} not available"
}

# resource "aws_security_group" "lb_sg" {
#   name        = "lb-security-group"
#   description = "Security group for the load balancer"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "Allow HTTP"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "Allow HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "Allow Health Check"
#     from_port        = 30080
#     to_port          = 30080
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"  # -1 означает все протоколы
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "lb-security-group"
#   }
# }

resource "yandex_vpc_security_group" "vm_sg" {
  name        = "vm-security-group"
  description = "Security group for virtual machines in Yandex Cloud"

  network_id = yandex_vpc_network.vpc.id

  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  ingress {
    protocol = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port   = 80
  }
}
