data "google_compute_regions" "available" {}

variable "vpc_network_name" {
  type = "string"
}

variable "vpc_network_prefix" {
  type = "string"
}

variable "vpc_network_cidr_block" {
  default = "10.0.0.0/16"
}

variable "auto_create_subnetworks" {
  type = "string"
  default = "false"
}
