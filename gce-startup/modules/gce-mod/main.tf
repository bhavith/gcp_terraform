resource "google_compute_instance" "vm_instance" {
   name = "terraform-workspace-instance-01"
   machine_type = "${var.machinetype}"
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
   metadata = "${merge(map("startup-script", "${var.startup_script}", "tf_depends_id", "${var.depends_id}"),var.metadata)}"
}   