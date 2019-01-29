data "template_file" "core-init" {
    template = "${file("scripts/startup.sh")}"
}


data "template_cloudinit_config"  "master" {
    part {
    filename     = "tmp/startup.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.core-init.rendered}"
  }
}


module "gce-master" {
#    source = "modules/gce-mod"
 #   zone = "eu-west2-c"
  #  network = "default"
    machinetype = "f1-micro"
    metadata {
        user-data = "${data.template_cloudinit_config.master.rendered}"
    }
}