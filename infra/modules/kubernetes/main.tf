data "google_client_config" "current" {}
data "google_compute_network" "devops-challenger-k8s-network" {
  name = "${var.cluster_vpc_network}"
}
resource "google_container_cluster" "devops-challenger-k8s" {
  name        = "${var.cluster_name}"
  network     = "${var.cluster_vpc_network}" 
  subnetwork  = "${data.google_compute_network.devops-challenger-k8s-network.subnetworks_self_links[0]}"
  region      = "${data.google_client_config.current.region}"

  master_auth {
    username = "${var.cluster_user_name}"
    password = "${var.cluster_user_pwd}"
  }

  remove_default_node_pool = true
  initial_node_count  = 1
  addons_config {
    kubernetes_dashboard { 
      disabled = true
    }
  }  
  
}

resource "google_container_node_pool" "devops-challenger-k8s-node-pool" {
  name       = "${var.cluster_name}-node-pool"
  region     = "${data.google_client_config.current.region}"
  cluster    = "${google_container_cluster.devops-challenger-k8s.name}"
  node_count = 1
  management {
    auto_repair = "true"
  }
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