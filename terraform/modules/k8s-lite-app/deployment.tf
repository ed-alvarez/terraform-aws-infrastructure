resource "kubernetes_deployment_v1" "lite-app" {
  metadata {
    name      = "lite-app"
    namespace = "default"
  }

  spec {
    selector {
      match_labels = {
        run = "lite-app"
      }
    }

    template {
      metadata {
        labels = {
          run = "lite-app"
        }
      }

      spec {
        container {
          name  = "lite-app"
          image = "${var.k8s_images_repo}/lite-app:${var.environment}"

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
