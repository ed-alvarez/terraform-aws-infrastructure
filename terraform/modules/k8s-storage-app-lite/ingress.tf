resource "kubernetes_ingress_v1" "storage-app-lite" {
  count = var.environment == "production" ? 1 : 0

  metadata {
    name      = "storage-app-lite"
    namespace = "default"

    annotations = {
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/certificate-arn" = "arn:aws:acm:us-east-1:064739708360:certificate/35246af5-cb08-41ef-8d87-c12616baae41"
      "alb.ingress.kubernetes.io/ssl-redirect"    = "443"
      "kubernetes.io/ingress.class"               = "alb"
      "alb.ingress.kubernetes.io/ssl-policy"      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
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
      host = "storage.koloni.io"

      http {
        path {
          path = "/*"

          backend {
            service {
              name = "storage-app-lite"

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
