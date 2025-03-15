resource "kubernetes_service_v1" "storage-app-lite" {
  count = var.environment == "production" ? 1 : 0

  metadata {
    name      = "storage-app-lite"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      run = "storage-app-lite"
    }

    port {
      name        = "http"
      node_port   = 30010
      port        = 80
      target_port = 80
    }
  }
}
