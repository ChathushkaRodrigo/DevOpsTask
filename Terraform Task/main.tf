provider "google" {
  project = var.gcp_project_id
}

data "google_container_cluster" "cluster" {
  name     = var.gke_cluster_name
  location = "us-central1-c"
}

resource "google_compute_address" "nginx" {
  name   = "nginx"
  region = "us-central1"
}

output "kubernetes_endpoint" {
  value = data.google_container_cluster.cluster.endpoint
}

output "nginx_external_ip" {
  value = google_compute_address.nginx.address
}