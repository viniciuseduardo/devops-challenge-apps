data "google_compute_zones" "available" {}

locals {
    zones = "${data.google_compute_zones.available.names}"
}

resource "google_compute_network" "devops-challenge-vpc" {
    name                    = "${var.vpc_network_name}"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
}

resource "google_compute_subnetwork" "devops-challenge-subnets" {
    depends_on      = ["google_compute_network.devops-challenge-vpc"]

    count           = "${length(local.zones)}"

    name            = "${var.vpc_network_prefix}-sb-${local.zones[count.index]}"
    ip_cidr_range   = "${cidrsubnet(var.vpc_network_cidr_block, 8, 0 + count.index)}"

    network         = "${google_compute_network.devops-challenge-vpc.self_link}"
}

resource "google_compute_firewall" "devops-challenge-fw-internal-rules" {
    name    = "${var.vpc_network_prefix}-fw-intenal"
    network = "${google_compute_network.devops-challenge-vpc.self_link}"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
    }

    allow {
        protocol = "udp"
    }

    source_ranges = ["${var.vpc_network_cidr_block}"]
}

resource "google_compute_firewall" "devops-challenge-fw-external-rules" {
    name    = "${var.vpc_network_prefix}-fw-external"
    network = "${google_compute_network.devops-challenge-vpc.self_link}"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports = ["22", "80", "443"]
    }

    source_ranges = ["0.0.0.0/0"]
}