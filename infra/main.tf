provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "devops-challenge-network" {
  source = "./modules/network"
  
  network_name = "${var.project_name}"
  network_cidr_block = "${var.vpc_cdir_range}"
}

module "devops-challenge-database" {
  source = "./modules/database"

  database_vpc_network  = "${module.devops-challenge-network.devops-challenge-vpc}"
  database_vpc_network_cdir = "${var.vpc_cdir_range}"
  database_server_name  = "${var.project_name}"
  database_user_name    = "${var.database_user_name}"
  database_user_pwd     = "${var.database_user_pwd}"
}
