resource "kubernetes_ingress_v1" "lite-app" {
  metadata {
    name      = "lite-app"
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
      host = var.environment == "production" ? "web.koloni.io" : "web-${var.environment}.koloni.io"

      http {
        path {
          path = "/*"

          backend {
            service {
              name = "lite-app"

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
