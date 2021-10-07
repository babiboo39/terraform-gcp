output "ip" {
  value = google_compute_instance.learn_vm.network_interface.0.network_ip
}
