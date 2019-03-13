resource "random_id" "db-name" {
  byte_length = 4
}

resource "random_string" "database-user-pwd" {
  length  = 12
  special = false
}

resource "google_sql_database_instance" "devops-challenge-instance" {
  name             = "${var.database_server_name}-${random_id.db-name.dec}"
  database_version = "${var.database_version}"

  settings {
    tier                        = "${var.database_tier}"
    activation_policy           = "ALWAYS"
    availability_type           = "ZONAL"
    backup_configuration        = {
        enabled = true
    }
    
    ip_configuration {
      authorized_networks = {
        value = "0.0.0.0/0"
      }
      ipv4_enabled = "true"
    }

    disk_autoresize = "${var.database_disk_autoresize}"
    disk_size       = "${var.database_disk_size}"
    disk_type       = "${var.database_disk_type}"

    maintenance_window {
      day          = "6"
      hour         = "23"
      update_track = "stable"
    }
  }
}

resource "google_sql_user" "devops-challenge-database-user" {
  instance   = "${google_sql_database_instance.devops-challenge-instance.name}"

  name       = "${var.database_user_name}"
  password   = "${random_string.database-user-pwd.result}"
  
  depends_on = ["google_sql_database_instance.devops-challenge-instance"]
}

resource "google_sql_database" "devops-challenge-database" {
  instance  = "${google_sql_database_instance.devops-challenge-instance.name}"

  name      = "${var.database_server_name}"

  depends_on = ["google_sql_database_instance.devops-challenge-instance"]
}