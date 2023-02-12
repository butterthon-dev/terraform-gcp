resource "google_project_service" "vpcaccess_api" {
  project = var.project_id
  service = "vpcaccess.googleapis.com"
}

module "vpcaccess_connector" {
  source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  version    = "~> 6.0"

  project_id = var.project_id
  vpc_connectors = [
    {
      name        = "central-serverless"
      region      = module.vpc_butterthon_dev.subnets["asia-northeast1/vpc-sub"].region
      subnet_name = module.vpc_butterthon_dev.subnets["asia-northeast1/vpc-sub"].name
      machine_type  = "e2-micro"
      min_instances = 2
      max_instances = 10
    }
  ]

  depends_on = [google_project_service.vpcaccess_api]
}
