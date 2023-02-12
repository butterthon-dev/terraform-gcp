module "private_service_access" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version = "14.0.0"

  project_id = var.project_id
  vpc_network = module.vpc_butterthon_dev.network_name
}

module "sql_iap_tcp" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "14.0.0"

  project_id           = var.project_id
  name                 = "sql-iap-tcp"
  random_instance_name = true

  database_version = "MYSQL_8_0"
  region           = var.region
  zone             = var.zone
  tier             = "db-f1-micro" # 検証用なので低スペックなマシンタイプを使用

  ip_configuration = {
    ipv4_enabled        = false # 外部IPアドレスは無効
    private_network     = module.vpc_butterthon_dev.network_id
    require_ssl         = false
    allocated_ip_range  = module.private_service_access.google_compute_global_address_name
    authorized_networks = []
  }

  deletion_protection = false # 検証用なので削除保護は無効

  additional_databases = [
    {
      name      = "iap-tcp",
      charset   = "utf8mb4"
      collation = "utf8mb4_bin"
    }
  ]

  depends_on = [module.private_service_access.peering_completed]
}
