

# Create network
resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}

resource "google_compute_firewall" "inbound-ip-ssh" {
    name = "allow-incoming-ssh-from-iap"
    project = var.project_id
    network = google_compute_network.vpc_network.self_link

    direction = "INGRESS"
    target_tags = ["allow-ssh"]
    source_ranges = [ "0.0.0.0/0" ]
    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}

resource "google_compute_global_address" "private_ip_address" {
    provider = google-beta
    project = var.project_id
    name = "private-ip-address"
    purpose = "VPC_PEERING"
    address_type = "INTERNAL"
    prefix_length = 16
    network = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
    network = google_compute_network.vpc_network.id
    service = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
