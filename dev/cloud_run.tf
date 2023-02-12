locals {
  default_template_annotations = {
    "autoscaling.knative.dev/maxScale": 2,
    "autoscaling.knative.dev/minScale": 1,
    "generated-by": "terraform",
    "run.googleapis.com/client-name": "terraform"
  }
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.2.0"

  # Required variables
  service_name           = "terraform-gcp-gce-8000"
  project_id             = var.project_id
  location               = var.region
  image                  = "asia-northeast1-docker.pkg.dev/${var.project_id}/terraform-gcp-gce-8000/fastapi"
  template_annotations   = local.default_template_annotations
  service_account_email  = module.cloud_run_butterthon_dev.email
  container_command      = ["./entrypoint_cloud.sh"]
  members                = ["allUsers"]

  ports = {
    "name": "http1",
    "port": 8000
  }

  depends_on = [module.cloud_run_butterthon_dev]
}
