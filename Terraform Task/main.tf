# Define the GCP provider
provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Define the GKE cluster
resource "google_container_cluster" "gke_cluster" {
  name               = var.gke_cluster_name
  location           ="us-central1"
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
  }

 

  # Allow traffic to/from nodes
  network_policy {
    enabled = false
  }
}

#Retrieve created cluster data from GCP
data "google_container_cluster" "cluster" {
  name     = var.gke_cluster_name
  location = "us-central1"
}

#Create resource for nginx deployment
resource "google_compute_address" "nginx" {
  name   = "nginx"
  region = "us-central1"
}

#output K8 endpoint
output "kubernetes_endpoint" {
  value = data.google_container_cluster.cluster.endpoint
}

#Output nginx ip
output "nginx_external_ip" {
  value = google_compute_address.nginx.address
}
