resource "google_compute_address" "address_nat_vpc_butterthon_dev" {
  name = "address-nat-vpc-butterthon-dev"
  region = module.vpc_butterthon_dev.subnets["asia-northeast1/vpc-sub-butterthon-dev"].region
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 4.0"
  project = var.project_id
  name    = "router-vpc-butterthon-dev"
  network = module.vpc_butterthon_dev.network_self_link
  region  = var.region

  nats = [{
    name                   = "nat-vpc-butterthon-dev"
    nat_ip_allocate_option = "MANUAL_ONLY"
    nat_ips                = [google_compute_address.address_nat_vpc_butterthon_dev.self_link]
  }]
}
