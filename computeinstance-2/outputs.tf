output "ipaddress" {
  value = google_compute_instance.machine1.*.network_interface
}