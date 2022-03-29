
provider "google" {
    project = "omar-devops"
    credentials = "${file("credentials.json")}"
}

# Cloud Run

resource "google_cloud_run_service" "cloudrun" {
  name     = "translate-app-cloudrun-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/omar-devops/translate-app-img:1.0.0"
      } 
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloudrun.location
  project     = google_cloud_run_service.cloudrun.project
  service     = google_cloud_run_service.cloudrun.name
  policy_data = data.google_iam_policy.noauth.policy_data
}