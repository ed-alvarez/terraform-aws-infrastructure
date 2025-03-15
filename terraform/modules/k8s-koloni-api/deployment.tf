resource "kubernetes_deployment_v1" "koloni-api" {
  metadata {
    name      = "koloni-api"
    namespace = "default"
  }

  spec {
    selector {
      match_labels = {
        run = "koloni-api"
      }
    }

    template {
      metadata {
        labels = {
          run = "koloni-api"
        }
      }

      spec {
        container {
          name  = "koloni-api"
          image = "${var.k8s_images_repo}/koloni-api:${var.environment}"

          env_from {
            config_map_ref {
              name = "koloni-api-${var.environment}-config"
            }
          }

          resources {
            limits = {
              cpu    = "800m"
              memory = "800Mi"
            }
            requests = {
              cpu    = "800m"
              memory = "800Mi"
            }
          }

          port {
            container_port = 5000
          }

          image_pull_policy = "Always"
        }
      }
    }
  }

  depends_on = [
    kubernetes_config_map_v1.koloni-api
  ]
}
