provider "google" {
  project = "static-balm-341806"
}
/*
resource "google_compute_network" "vpc_network" {
  name = "default"
}
*/
resource "google_compute_autoscaler" "foobar" {
  name = "my-autoscaler"
  project = "static-balm-341806"
  zone = "us-central1-c"
  target = google_compute_instance_group_manager.foobar.self_link

  autoscaling_policy {
    max_replicas = 5
    min_replicas = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_instance_template" "foobar" {
  name = "my-instance-template"
  machine_type = "f1-micro"
  can_ip_forward = false
  project = "static-balm-341806"
  tags = ["foo", "bar", "allow-lb-service"]

  disk {
    source_image = data.google_compute_image.centos_7.self_link
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }
/*
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }*/
}

resource "google_compute_target_pool" "foobar" {
  name = "my-target-pool"
  project = "static-balm-341806"
  region = "us-central1"
}

resource "google_compute_instance_group_manager" "foobar" {
  name = "my-igm"
  zone = "us-central1-c"
  project = "static-balm-341806"
  version {
    instance_template = google_compute_instance_template.foobar.self_link
    name = "primary"
  }

  target_pools = [google_compute_target_pool.foobar.self_link]
  base_instance_name = "terraform"
}

data "google_compute_image" "centos_7" {
  family = "centos-7"
  project = "centos-cloud"
}

module "lb" {
  source = "GoogleCloudPlatform/lb/google"
  version = "2.2.0"
  region = "us-central1"
  name = "load-balancer"
  service_port = 80
  target_tags = ["my-target-pool"]
  network = "default"
}
