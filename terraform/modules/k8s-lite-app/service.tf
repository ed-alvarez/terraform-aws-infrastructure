resource "kubernetes_service_v1" "lite-app" {
  metadata {
    name      = "lite-app"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      run = "lite-app"
    }

    port {
      name        = "http"
      node_port   = 30012
      port        = 80
      target_port = 80
    }
  }
}
