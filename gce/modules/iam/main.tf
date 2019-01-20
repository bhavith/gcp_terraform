
resource "google_service_account" "terraform_local_executor" {
   account_id = "${var.account_id}"
   display_name = "${var.account_id}"
}

resource "google_project_iam_binding" "project" {
  project = "${var.project}"
  role    = "${var.role}"
  members = [
   "${var.members}"    
  ]
}