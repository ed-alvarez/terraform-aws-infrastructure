resource "kubernetes_deployment_v1" "delivery-webapp" {
  metadata {
    name      = "delivery-webapp"
    namespace = "default"
  }

  spec {
    selector {
      match_labels = {
        run = "delivery-webapp"
      }
    }

    template {
      metadata {
        labels = {
          run = "delivery-webapp"
        }
      }

      spec {
        container {
          name  = "delivery-webapp"
          image = "${var.k8s_images_repo}/delivery-webapp:${var.environment}"

          resources {
            limits = {
              cpu    = "600m"
              memory = "800Mi"
            }
            requests = {
              cpu    = "600m"
              memory = "800Mi"
            }
          }

          port {
            container_port = 80
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}
