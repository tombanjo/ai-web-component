terraform {
  backend "gcs" {
    bucket         = "terraform-remote-state-ai-web-component-00"
    prefix         = "dev/terraform/state/prototype"
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Project + basic config
data "google_project" "project" {}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ========== Cloud Run ==========

resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.service_name}/${var.service_name}:latest"
        ports {
          container_port = 8080
        }
        env {
          name  = "CORS_ALLOWED_ORIGIN"
          value = var.cors_origin
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

# Allow unauthenticated access to Cloud Run
resource "google_cloud_run_service_iam_member" "run_invoker" {
  service  = google_cloud_run_service.service.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
