module "vpc_butterthon_dev" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0"

  project_id   = var.project_id
  network_name = "vpc-butterthon-dev"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "vpc-sub-butterthon-dev"
      subnet_ip     = "10.10.10.0/24" # 10.10.10.1〜10.10.10.254
      subnet_region = var.region
    },
    {
      subnet_name   = "vpc-sub-vpcaccess-connector"
      subnet_ip     = "10.10.20.0/28" # 10.10.10.1〜10.10.10.254
      subnet_region = var.region
    }
  ]

  firewall_rules = [
    {
      name      = "fw-allow-ssh-ingress-from-ssh"
      direction = "INGRESS"
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      ranges = [
        "35.235.240.0/20" # IAP が TCP 転送に使用するすべての IP アドレス
      ]
    },
  ]
}
