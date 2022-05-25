

resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance"
    machine_type = "e2-micro"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
    }
    tags = ["allow-ssh"]

    network_interface {
        network = google_compute_network.vpc_network.self_link
        access_config {
        }
    }
}
