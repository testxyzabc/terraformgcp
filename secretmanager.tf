#ensure to enable secret manager api and give your service account secretmanager admin permissions


provider "google" {
  project     = "static-balm-341806"
  region      = "us-central1"
}
resource "google_secret_manager_secret" "admin-password" {

  secret_id = "mysecrethere"
  replication {
    automatic = true
  }
}
# Add the secret data for local-admin-password secret
resource "google_secret_manager_secret_version" "admin-password" {
  secret = google_secret_manager_secret.admin-password.id
  secret_data = "TopSecret@123"
}

#reading secret data

data "google_secret_manager_secret_version" "admin-password" {
  secret   = "mysecrethere"
  version  = "2"
  depends_on = [google_secret_manager_secret_version.admin-password]
}


output "domain-admin-password" {
  value = nonsensitive(data.google_secret_manager_secret_version.admin-password.secret_data)
}
