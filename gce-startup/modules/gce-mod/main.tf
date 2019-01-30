resource "google_compute_instance" "vm_instance" {
   name = "terraform-workspace-instance-02"
   machine_type = "${var.machinetype}"
   zone = "${var.instanceZone}"
   network_interface {
     network = "default"
     access_config = {
     }
   }
   project = "${data.google_project.project.id}"
   allow_stopping_for_update = true
   service_account {
      email = "314462922776-compute@developer.gserviceaccount.com"
      scopes = [ "cloud-platform" ]
   }
   boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"    
      }   
   }
   metadata = "${var.metadata}"
}   