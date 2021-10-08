resource "google_compute_instance" "learn_vm" {
    name            = var.name
    machine_type    = var.machine_type
    zone            = var.zone
    tags            = ["ssh-allow", "http-allow"]

    boot_disk {
        initialize_params {
            image  = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }
    metadata = {
      sshKeys = "rulikalit:${file("~/.ssh/id_rsa.pub")}"
    }
    network_interface {
        network = google_compute_network.vpc_network.name
        access_config {
        }
    }

}

resource "google_compute_network" "vpc_network" {
    name = "terraform-net"
}

resource "google_compute_firewall" "ssh-rule" {
    name    = "demo-ssh"
    network = google_compute_network.vpc_network.name
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    target_tags   = ["ssh-allow"]
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http-rule" {
    name    = "http-access"
    network = google_compute_network.vpc_network.name
    allow {
        protocol = "tcp"
        ports    = ["80", "443"]
    }
    target_tags   = ["http-allow"]
    source_ranges = ["0.0.0.0/0"] 
}