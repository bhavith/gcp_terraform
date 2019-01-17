variable "clustername" {
  description = "The clustername"
  type     = "string"
}

locals {
  default_name_prefix = "${var.clustername}-01"
}

resource "google_container_cluster" "primary" {
  name               = "${local.default_name_prefix}"
  zone               =  "europe-west2-b"
  initial_node_count = 3

 # additional_zones = [
 #   "europe-west2-a"
 # ]
  network = "default"
  project="sandbox-devops-2018"

  node_config {
    machine_type = "f1-micro"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      project = "devops"
    }

    tags = ["devops"]
  }
}

output "name" {
  value = "${google_container_cluster.primary.name}"
}