provider "google" {
   project="sandbox-devops-2018"
   region="europe-west2"
   zone="europe-west2-c"
}

resource "google_compute_instance" "vm_instance" {
   name = "terraform-workspace-instance"
   machine_type = "f1-micro"
   allow_stopping_for_update = true
   service_account {
      email = "${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
      scopes = [ "cloud-platform" ]
   }
   boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"    
      } 
   }

   network_interface {
     network = "default"
     access_config = {
     }
   }
}

resource "google_service_account" "terraform_local_executor" {
   account_id = "tf-local-executor"
   display_name = "tf-local-executor"
}

resource "google_project_iam_binding" "project" {
  project = "sandbox-devops-2018"
  role    = "roles/editor"
  members = [
    "serviceAccount:${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
  ]
}

#resource "google_service_account_iam_binding" "admin-account-iam" {
  # service_account_id = "${google_service_account.terraform_local_executor.account_id}"
 #  service_account_id = "projects/sandbox-devops-2018/serviceAccounts/${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
  # role        = "roles/editor"
  # members = [
  #  "serviceAccount:${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
  # ]
#}