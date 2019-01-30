resource "google_filestore_instance" "instance" {
  name = "${var.filestorename}"
  zone = "europe-west2-c"
  tier = "STANDARD"
  project = "sandbox-devops-2018"

  file_shares {
    capacity_gb = "${var.filestoresize}" 
    name        = "share1"
  }

  networks {
    network = "default"
    modes   = ["MODE_IPV4"]
  }
}

output "ip" {
  value = "${google_filestore_instance.instance.networks.ip_addresses}"
}