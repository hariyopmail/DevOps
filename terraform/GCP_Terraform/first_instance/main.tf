resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_disk" "vol_production" {
  name = "prod-desk"
  type = "pd-ssd"
  zone = "us-east4-a"
  size = "10"
}

resource "google_compute_attached_disk" "vol_production" {
  disk     = "${google_compute_disk.vol_production.self_link}"
  instance = "${google_compute_instance.production[0].self_link}"
}

resource "google_compute_disk" "vol_certification" {
  name = "cert-desk"
  type = "pd-ssd"
  zone = "us-east4-b"
  size = "10"
}

resource "google_compute_attached_disk" "vol_certification" {
  disk     = "${google_compute_disk.vol_certification.self_link}"
  instance = "${google_compute_instance.certification[0].self_link}"
}


resource "google_compute_disk" "vol_development" {
  name = "dev-desk"
  type = "pd-ssd"
  zone = "us-east4-b"
  size = "10"
}

resource "google_compute_attached_disk" "vol_development" {
  disk     = "${google_compute_disk.vol_development.self_link}"
  instance = "${google_compute_instance.development[0].self_link}"
}

resource "google_compute_instance" "production" {
  count        = 1
  name         = "production-${count.index + 1}"
  machine_type = var.machine_type["production"]
  zone         = "us-east4-a"

  boot_disk {
    initialize_params {
      image = var.image
      size  = "10"

    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt upgrade -y && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello Production World!</h1></body></html>' | sudo tee /var/www/html/index.html"

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  depends_on = [google_compute_instance.certification]
}


resource "google_compute_instance" "certification" {
  count        = 1
  name         = "certification-${count.index + 1}"
  machine_type = var.machine_type["certification"]
  zone         = "us-east4-b"

  boot_disk {
    initialize_params {
      image = var.image
      size  = "10"

    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello Certification World!</h1></body></html>' | sudo tee /var/www/html/index.html"

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  depends_on = [google_compute_instance.development]
}


resource "google_compute_instance" "development" {
  count        = 1
  name         = "development-${count.index + 1}"
  machine_type = var.machine_type["development"]
  zone         = "us-east4-b"

  boot_disk {
    initialize_params {
      image = var.image
      size  = "10"
    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello Development World!</h1></body></html>' | sudo tee /var/www/html/index.html"

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}


# OutPut Production
output "machine_type_prod" { value = "${google_compute_instance.production.*.machine_type}" }
output "name_prod" { value = "${google_compute_instance.production.*.name}" }
output "zone_prod" { value = "${google_compute_instance.production.*.zone}" }
output "instance_id_prod" { value = "${join(", ", google_compute_instance.production.*.id)}" }
