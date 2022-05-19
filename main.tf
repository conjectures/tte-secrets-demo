provider "google" {
    project = "admiral-tte-demo"
    region = "europe-west2"
    zone = "europe-west2-a"
}

# Create network
resource "google_compute_network" "vpc_network" {
    name = "vpc-network"
}


# Create metadata repo
resource "google_sql_database_instance" "main" {
    name = "metadata-main"
    database_version = "SQLSERVER_2017_EXPRESS"
    region = "europe-west2"
    deletion_protection = "false"
    settings {
        tier = "db-f1-micro"
        # ip_configuration
    }
}

data "google_secret_manager_secret_version" "my-secret" {
    provider = google
    secret = "my-secret"
    version = "1"
}

output "something" {
    value = data.google_secret_manager_secret_version.my-secret.secret_data
    sensitive = false
}
