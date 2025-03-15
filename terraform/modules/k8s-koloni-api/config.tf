resource "kubernetes_config_map_v1" "koloni-api" {
  metadata {
    name = "koloni-api-${var.environment}-config"
    labels = {
      "app" = "koloni-api"
    }
  }

  data = var.koloni_api_env
}