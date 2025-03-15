resource "kubernetes_service_v1" "delivery-webapp" {
  metadata {
    name      = "delivery-webapp"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      run = "delivery-webapp"
    }

    port {
      name        = "http"
      node_port   = 30011
      port        = 80
      target_port = 80
    }
  }
}
