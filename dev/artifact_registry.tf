locals {
  repositories = {
    terraform_gcp_gce_8000 = {
        name        = "terraform-gcp-gce-8000",
        description = ""
    }
  }
}

resource "google_artifact_registry_repository" "artifact_registry_butterth_dev" {
  location      = var.region
  format        = "DOCKER"

  for_each      = local.repositories
  repository_id = each.value.name
  description   = each.value.description
}
