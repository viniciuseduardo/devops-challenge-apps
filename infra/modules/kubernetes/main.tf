data "google_client_config" "current" {}
data "google_compute_network" "devops-challenger-k8s-network" {
  name = "${var.cluster_vpc_network}"
}
data "google_compute_subnetwork" "devops-challenger-k8s-subnetwork" {
  region = "${data.google_client_config.current.region}"
}

resource "google_container_cluster" "devops-challenger-k8s" {
  name        = "${var.cluster_name}"
  network     = "${var.cluster_vpc_network}" 
  subnetwork  = "${data.google_compute_subnetwork.devops-challenger-k8s-subnetwork.name}"
  region      = "${data.google_client_config.current.region}"

  master_auth {
    username = "${var.cluster_user_name}"
    password = "${var.cluster_user_pwd}"
  }

  remove_default_node_pool = true
  initial_node_count  = 1
}

resource "google_container_node_pool" "devops-challenger-k8s-node-pool" {
  name       = "${var.cluster_name}-node-pool"
  cluster    = "${google_container_cluster.devops-challenger-k8s.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "${var.cluster_node_type}"

    disk_size_gb  = "${var.cluster_node_disk_size}"
    disk_type     = "${var.cluster_node_disk_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}