provider "google" {
   project="sandbox-devops-2018"
   region="europe-west2"
   zone="${var.clusterzone}"
}

variable "machineType" {
  default = "f1-micro"
  type = "string"
  description = "Compute engine machine type to be used"
}


resource "google_compute_instance" "vm_instance" {
   name = "terraform-workspace-instance"
   machine_type = "${var.machineType}"
   allow_stopping_for_update = true
   service_account {
      email = "tf-local-executor@sandbox-devops-2018.iam.gserviceaccount.com"
      scopes = [ "cloud-platform" ]
   }
   boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"    
      }
   }

#   provisioner "file" {
#        source = "startup.sh"
#        destination = "/tmp/startup.sh"
#        connection {
#                type = "ssh"
#                user = "bhavithk"
#                private_key = "${file("~/.ssh/google_compute_engine")}"
#        }  
#   }


   metadata_startup_script = "touch /tmp/test.txt && touch /tmp/abc.xyz" 
   
   network_interface {
     network = "default"
     access_config = {
     }
   }
}

module "cfs" {
   source = "./modules/cfs"
   filestorename = "cfs-gce-storage"
   filestoresize =  1024
}


module "iam" {
   source = "./modules/iam"
   account_id = "tf-local-executor"
   project = "sandbox-devops-2018"
   role    = "roles/editor"
   members = "serviceAccount:tf-local-executor@sandbox-devops-2018.iam.gserviceaccount.com"
}


#resource "google_service_account_iam_binding" "admin-account-iam" {
  # service_account_id = "${google_service_account.terraform_local_executor.account_id}"
 #  service_account_id = "projects/sandbox-devops-2018/serviceAccounts/${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
  # role        = "roles/editor"
  # members = [
  #  "serviceAccount:${google_service_account.terraform_local_executor.account_id}@sandbox-devops-2018.iam.gserviceaccount.com"
  # ]
#}
