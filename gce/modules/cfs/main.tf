resource "google_filestore_instance" "instance" {
  name = "${var.filestorename}"
  zone = "europe-west2-c"
  tier = "STANDARD"

  file_shares {
    capacity_gb = "${var.filestoresize}" 
    name        = "share1"
  }

  networks {
    network = "default"
    modes   = ["MODE_IPV4"]
  }
}
