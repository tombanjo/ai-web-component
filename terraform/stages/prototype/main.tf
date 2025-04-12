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

resource "google_service_account" "custom_iap_user" {
  account_id   = "iap-authenticated-user"
  display_name = "IAP Authenticated User (No Roles)"
}


# Allow IAP to invoke Cloud Run
resource "google_cloud_run_service_iam_member" "run_invoker" {
  service  = google_cloud_run_service.service.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.custom_iap_user.email}"
}

# ========== IAP Binding for Chat ==========
# Configures IAP access for the chat service
resource "google_cloud_run_service_iam_binding" "iap_access" {
  project  = var.project_id
  service  = google_cloud_run_service.service.name
  location = var.region

  role    = "roles/iap.httpsResourceAccessor"
  members = ["domain:gmail.com"]
}
