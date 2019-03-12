variable "region" {
  default="us-central1"
}

variable "project_id" {
  default="devops-challenge-stone"
}

variable "project_name" {
  type = "string"
  default = "devops-challenge-stone"
}

variable "vpc_cdir_range" {
  default = "10.0.0.0/16"
}

variable "database_user_name" {
  type = "string"
}

variable "database_user_pwd" {
  type = "string"
}

variable "cluster_user_name" {
  type = "string"
}

variable "cluster_user_pwd" {
  type = "string"
}