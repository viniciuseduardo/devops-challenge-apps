variable "database_vpc_network" {}

variable "database_vpc_network_name" {}

variable "database_vpc_network_cdir" {}

variable "database_server_name" {
  type = "string"
}

variable "database_user_name" {
  type = "string"
}

variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "database_disk_autoresize" {
  default = true
}

variable "database_disk_size" {
  default = 10
}

variable "database_disk_type" {
  default = "PD_SSD"
}

variable "database_tier" {
  default = "db-f1-micro"
}