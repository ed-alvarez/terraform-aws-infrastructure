resource "kubernetes_deployment_v1" "lockers-admin-panel" {
  metadata {
    name      = "lockers-admin-panel"
    namespace = "default"
  }

  spec {
    selector {
      match_labels = {
        run = "lockers-admin-panel"
      }
    }

    template {
      metadata {
        labels = {
          run = "lockers-admin-panel"
        }
      }

      spec {
        container {
          name  = "lockers-admin-panel"
          image = "${var.k8s_images_repo}/lockers-admin-panel:${var.environment}"

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
