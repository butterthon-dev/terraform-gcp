# gcloud compute ssh butterthon-dev@gce-vpn-test
resource "google_compute_instance" "gce_vpn_test" {
  name         = "gce-vpn-test"
  machine_type = "e2-standard-2"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = module.vpc_butterthon_dev.subnets["asia-northeast1/vpc-sub"].self_link
  }
#   metadata_startup_script = <<EOF
# # 依存パッケージ更新&インストール
# sudo apt update && sudo apt install -y mysql-server, apt-transport-https ca-certificates curl software-properties-common

# # 公式DockerリポジトリのGPGキーをシステムに追加
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# # DockerリポジトリをAPTソースに追加
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# # パッケージリストを再更新してdockerをインストール
# sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# # docker-composerダウンロード
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# # Gitリポジトリクローン
# sudo mkdir -p /var/www/
# sudo git clone https://github.com/butterthon-dev/terraform-gcp-gce-8000.git
# cd /var/www/terraform-gcp-gce-8000
# sudo docker-compose up -d
# EOF

  # depends_on = [module.cloud_router]
}
