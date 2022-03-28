terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
    project = "devops-343007"
}

# Cloud Run

resource "google_cloud_run_service" "cloudrun" {
  name     = "cloudrun-service-test-1"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/devops-343007/translate-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}