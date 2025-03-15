resource "kubernetes_service_v1" "lockers-admin-panel" {
  metadata {
    name      = "lockers-admin-panel"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      run = "lockers-admin-panel"
    }

    port {
      name        = "http"
      node_port   = 30008
      port        = 80
      target_port = 80
    }
  }
}
