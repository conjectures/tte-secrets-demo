

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
