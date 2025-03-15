resource "kubernetes_ingress_v1" "koloni-api" {
  metadata {
    name      = "koloni-api"
    namespace = "default"

    annotations = {
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/certificate-arn" = "arn:aws:acm:us-east-1:064739708360:certificate/7078705b-82ff-422c-b3bf-cee047eb0b6e"
      "alb.ingress.kubernetes.io/ssl-redirect"    = "443"
      "alb.ingress.kubernetes.io/ssl-policy"      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      "kubernetes.io/ingress.class"               = "alb"
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([
        {
          "HTTP" : 80
        },
        {
          "HTTPS" : 443
        }
      ])
    }
  }

  spec {
    rule {
      host = var.environment == "production" ? "api.koloni.io" : "${var.environment}.api.koloni.io"

      http {
        path {
          path = "/*"

          backend {
            service {
              name = "koloni-api"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "koloni-ws" {
  metadata {
    name = "koloni-ws"

    annotations = {
      "alb.ingress.kubernetes.io/scheme"               = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"          = "ip"
      "kubernetes.io/ingress.class"                    = "alb"
      "nginx.ingress.kubernetes.io/websocket-services" = "koloni-ws"
    }
  }

  spec {
    rule {
      host = var.environment == "production" ? "ws.koloni.io" : "ws-${var.environment}.koloni.io"

      http {
        path {
          path = "/*"

          backend {
            service {
              name = "koloni-api"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
