provider "google" {
    project = "admiral-tte-demo"
    region = "europe-west2"
    zone = "europe-west2-a"
}

# Create network
resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}


output "something" {
    value = data.google_secret_manager_secret_version.my-secret.secret_data
    sensitive = true
}

# Create metadata repo
resource "google_sql_database_instance" "main" {
    name = "metadata-main"
    database_version = "SQLSERVER_2019_EXPRESS"
    deletion_protection = "false"
    root_password = data.google_secret_manager_secret_version.my-secret.secret_data
    settings {
        tier = "db-custom-1-3840"
        # ip_configuration
    }
}

# Specify 'google_secret_manager_secret_version' as DATA SOURCE 
data "google_secret_manager_secret_version" "my-secret" {
    provider = google
    secret = "my-secret"
    # Ignore version to use latest
    #version = "1"
}


resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance"
    machine_type = "e2-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }
    network = google_compute_network.vpc_network.self_link
}
