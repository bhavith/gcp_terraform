data "template_file" "core-init" {
    template = "${file("scripts/startup.sh")}"
    vars = {
       ipaddress = "${var.cfsipaddress}"
    }
}


data "template_cloudinit_config"  "master" {
    part {
    filename     = "startup.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.core-init.rendered}"
  }
}

#module "cfs" {
#   source = "modules/cfs"
#   filestorename = "cfs-gce-storage"
#  filestoresize =  1024
#}

module "gce-master" {
    source = "modules/gce-mod"
 #   zone = "eu-west2-c"
  #  network = "default"
    machinetype = "${var.gcemachinetype}"
    instanceZone = "${var.instanceZone}"
    metadata {
       startup-script          = "${data.template_file.core-init.rendered}"
    }
}