provider "google" {
  project = var.gcp_project_id
}

data "google_container_cluster" "cluster" {
  name     = var.gke_cluster_name
  location = "us-central1-c"
}

data "google_compute_global_address" "nginx_lb_ip" {
  name = "${data.google_container_cluster.cluster.name}-http-lb-ip"
}

output "kubernetes_endpoint" {
  value = data.google_container_cluster.cluster.endpoint
}

data "google_compute_address" "lb_ip" {
  name =  data.google_container_cluster.cluster.name
  region = google_container_cluster.cluster.region
}
output "nginx_external_ip" {
  value = data.google_compute_address.lb_ip.address
}