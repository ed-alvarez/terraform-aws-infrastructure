resource "kubernetes_pod_disruption_budget_v1" "koloni-api" {
  metadata {
    name      = "koloni-api"
    namespace = "default"
  }

  spec {
    max_unavailable = "1"

    selector {
      match_labels = {
        run = "koloni-api"
      }
    }
  }
}
