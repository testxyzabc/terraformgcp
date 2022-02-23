provider "google" {
  project = var.projectname
  region = var.region
}
resource "google_container_cluster" "primary" {
  name     = "${var.projectname}-gke"
  location = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
}
resource "google_container_node_pool" "nodes" {
  cluster = google_container_cluster.primary.id
  node_count = 1
}
