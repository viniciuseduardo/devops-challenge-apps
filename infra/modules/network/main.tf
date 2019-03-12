locals {
  regions_count = "${length(data.google_compute_regions.available.names)}"
}

resource "google_compute_network" "devops-challenge-vpc" {
    name                    = "${var.network_name}-vpc"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
}

resource "google_compute_subnetwork" "devops-challenge-subnets" {
    depends_on      = ["google_compute_network.devops-challenge-vpc"]

    count           = "${local.regions_count}"

    name            = "${var.network_name}-subnet-${count.index}"
    ip_cidr_range   = "${cidrsubnet(var.network_cidr_block, 8, 0 + count.index)}"
    region          = "${data.google_compute_regions.available.names[count.index]}"

    network         = "${google_compute_network.devops-challenge-vpc.self_link}"
}

resource "google_compute_firewall" "devops-challenge-fw-internal-rules" {
    name    = "${var.network_name}-fw-intenal"
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

    source_ranges = ["${var.network_cidr_block}"]
}

resource "google_compute_firewall" "devops-challenge-fw-external-rules" {
    name    = "${var.network_name}-fw-external"
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