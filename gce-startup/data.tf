data "google_project" "project" {
    project_id = "sandbox-devops-2018"
}


terraform {
  backend "gcs" {
    bucket  = "sandbox-devops-storage"
    prefix  = "terraform/state/gce-startup"
  }
}