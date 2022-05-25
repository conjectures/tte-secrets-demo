
provider "google" {
    project = var.project_id
    region = "europe-west2"
    zone = "europe-west2-a"
}



output "something" {
    value = data.google_secret_manager_secret_version.my-secret.secret_data
    sensitive = true
}

# Specify 'google_secret_manager_secret_version' as DATA SOURCE 
data "google_secret_manager_secret_version" "my-secret" {
    provider = google
    secret = "my-secret"
    # Ignore version to use latest
    #version = "1"
}

# Create metadata repo
resource "google_sql_database_instance" "main" {
    name = "metadata-main-${random_string.sql_suffix.result}"
    database_version = "SQLSERVER_2019_EXPRESS"
    deletion_protection = "false"
    root_password = data.google_secret_manager_secret_version.my-secret.secret_data
    settings {
        tier = "db-custom-1-3840"
        # ip_configuration
        ip_configuration {
            ipv4_enabled = false
            private_network = google_compute_network.vpc_network.id
        }
    }
}


resource "random_string" "sql_suffix" {
    length = 3
    special = false
    # gcp instance names shouldn't contain capital letters
    upper = false
}

output "something2" {
    value = random_string.sql_suffix
}
