resource "kubernetes_deployment_v1" "storage-app-lite" {
  count = var.environment == "production" ? 1 : 0
  
  metadata {
    name      = "storage-app-lite"
    namespace = "default"
  }

  spec {
    selector {
      match_labels = {
        run = "storage-app-lite"
      }
    }

    template {
      metadata {
        labels = {
          run = "storage-app-lite"
        }
      }

      spec {
        container {
          name  = "storage-app-lite"
          image = "${var.k8s_images_repo}/storage-app-lite:latest"

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
