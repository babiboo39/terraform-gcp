resource "google_compute_instance" "learn_vm" {
    name            = var.name
    machine_type    = var.machine_type
    # region          = var.region
    zone            = var.zone
    tags            = ["ssh-allow"]

    boot_disk {
        initialize_params {
            image  = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }
    metadata = {
      sshKeys = "rulikalit:${file("~/.ssh/id_rsa.pub")}"
    }
    network_interface {
        network = "default"
        access_config {
        }
    }

}

# resource "google_compute_network" "vpc_network" {
#     name = "terraform-net"
#}

resource "google_compute_firewall" "ssh-rule" {
    name    = "demo-ssh"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    target_tags   = ["ssh-allow"]
    source_ranges = ["0.0.0.0/0"]
}