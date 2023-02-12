module "service_account_pubsub_push" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.0"

  project_id = var.project_id
  names      = ["pubsub-push"]
  project_roles = [
    "${var.project_id}=>roles/cloudfunctions.invoker",
  ]
}

module "cloud_run_butterthon_dev" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.0"

  project_id = var.project_id
  names      = ["cloud-run-butterthon-dev"]
  project_roles = [
    "${var.project_id}=>roles/logging.logWriter",
  ]
}
