module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 5.0"

  project_id = var.project_id
  topic      = "butterthon-dev-topic"
  push_subscriptions = [
    {
      name                  = "butterthon-dev-healthy"
      ack_deadline_seconds  = 20     # メッセージを確認するまでの最大時間
      push_endpoint         = "https://asia-northeast1-butterthon-dev.cloudfunctions.net/function-butterthon-dev"
      x-goog-version        = "v1"
      expiration_policy     = "1209600s"
      max_delivery_attempts = 5      # メッセージの配信試行回数の最大値
      maximum_backoff       = "600s" # メッセージの連続配信間の最大遅延時間
      minimum_backoff       = "300s" # メッセージの連続配信間の最小遅延時間
      oidc_service_account_email = module.service_account_pubsub_push.email
    #   audience             = 
    #   filter                     = "attributes.domain = \"com\""
    }
  ]
}
