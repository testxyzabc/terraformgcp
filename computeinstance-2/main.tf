provider "google" {
  project = "static-cirrus-305016"
  zone    = "us-central1-c"
}
resource "google_compute_instance" "machine1" {
  count        = length(var.list)
  machine_type = var.machinetype
  name         = "machine-${count.index}"
  tags = ["mymachines"]
  boot_disk {
    initialize_params {
      image = var.imagename
     # size = "30"
    }
  }
  #labels { (key pairs, like tags in aws)
 # env =
#}
  #metadata {}
  network_interface {
    network = var.networkname
    access_config {

    }
  }
  metadata_startup_script = file("startup.sh")
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = var.networkname

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

#  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_disk" "newdisk" {
  name = "datadisk"
  type = "pd-ssd"
  zone = "us-central1-c"
  size = "10"
}
#resource "google_compute_attached_disk" "" {
 # name = ""
 # disk = ""
#  instance = ""
#}
