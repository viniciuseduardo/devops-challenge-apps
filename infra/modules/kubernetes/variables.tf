variable "cluster_vpc_network" {}

variable "cluster_name" {
  type = "string"
}

variable "cluster_user_name" {
  type = "string"
}

variable "cluster_user_pwd" {
  type = "string"
}

variable "cluster_node_disk_size" {
  default = 10
}

variable "cluster_node_disk_type" {
  default = "pd-standard"
}

variable "cluster_node_type" {
  default = "f1-micro"
}