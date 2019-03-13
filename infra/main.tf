provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "devops-challenge-network" {
  source = "./modules/network"
  
  vpc_network_name        = "${var.project_name}-vpc"
  vpc_network_prefix      = "${var.project_name}"
  vpc_network_cidr_block  = "${var.vpc_cdir_range}"
}

module "devops-challenge-database" {
  source = "./modules/database"

  database_vpc_network      = "${module.devops-challenge-network.devops-challenge-vpc}"
  database_vpc_network_name = "${module.devops-challenge-network.devops-challenge-vpc-name}"
  database_vpc_network_cdir = "${var.vpc_cdir_range}"

  database_server_name      = "${var.project_name}-db"
  database_user_name        = "${var.database_user_name}"
}

module "devops-challenge-k8s" {
  source = "./modules/kubernetes"

  cluster_vpc_network       = "${module.devops-challenge-network.devops-challenge-vpc-name}"

  cluster_name      = "${var.project_name}-k8s"
  cluster_user_name = "${var.cluster_user_name}"
}

provider "kubernetes" {
  host = "https://${module.devops-challenge-k8s.cluster_endpoint}"

  username = "${var.cluster_user_name}"
  password = "${module.devops-challenge-k8s.cluster_user_pwd}"
}

module "devops-challenge-deploy-api" {
  source = "./modules/deploy/api"
  
  database_connection_string = "${module.devops-challenge-database.database_connection_string}"
}
