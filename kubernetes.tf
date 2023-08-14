resource "kubernetes_namespace" "jenkins-pipeline" {
  metadata {
    name = "jenkins-pipeline"
  }
}

resource "kubernetes_deployment" "jenkins-pipeline" {
  metadata {
    name = "k8s-jenkins"
    labels = {
      app = "Jenkins Pipeline"
    }
    namespace = "jenkins-pipeline"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "Jenkins Pipeline"
      }
    }

    template {
      metadata {
        labels = {
          app = "Jenkins Pipeline"
        }
      }

      spec {
        container {
          image = "jenkins/jenkins:lts"
          name  = "jenkins"

          resources {
            limits = {
              cpu    = "1000m"
              memory = "2Gi"
            }
            requests = {
              cpu    = "500m"
              memory = "500Mi"
            }
          }
        }
      }
    }
  }
}
