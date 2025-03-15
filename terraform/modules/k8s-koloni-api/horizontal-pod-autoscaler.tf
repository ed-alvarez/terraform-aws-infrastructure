resource "kubernetes_horizontal_pod_autoscaler_v1" "koloni-api" {
  metadata {
    name      = "koloni-api"
    namespace = "default"
  }

  spec {
    min_replicas = 1
    max_replicas = var.environment == "production" ? 15 : 5

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "koloni-api"
    }

    target_cpu_utilization_percentage = 90
  }
}
