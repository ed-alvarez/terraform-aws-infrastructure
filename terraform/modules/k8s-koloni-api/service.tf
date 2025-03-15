resource "kubernetes_service_v1" "koloni-api" {
  metadata {
    name      = "koloni-api"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      run = "koloni-api"
    }

    port {
      name        = "http"
      node_port   = 30007
      port        = 80
      target_port = 5000
    }
  }
}

resource "kubernetes_service_v1" "koloni-ws" {
  metadata {
    name      = "koloni-ws"
    namespace = "default"
  }

  spec {
    type = "NodePort"

    selector = {
      service = "koloni-api"
    }

    port {
      name        = "websocket"
      node_port   = 30006
      protocol    = "TCP"
      port        = 80
      target_port = 5000
    }
  }
}
