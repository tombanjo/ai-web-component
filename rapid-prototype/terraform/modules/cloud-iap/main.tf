terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_iap_brand" "project_brand" {
  support_email     = "support@example.com"
  application_title = "Cloud IAP protected Application"
  project           = var.project_id
}

resource "google_iap_client" "project_client" {
  display_name = "IAP Client"
  brand        = google_iap_brand.project_brand.name
}

resource "google_iap_web_iam_member" "oauth_consent" {
  project = var.project_id
  role    = "roles/iap.httpsResourceAccessor"
  member  = "allAuthenticatedUsers"
}

resource "google_iap_web_backend_service_iam_member" "member" {
  project             = var.project_id
  web_backend_service = var.backend_service_name
  role                = "roles/iap.httpsResourceAccessor"
  member              = "allAuthenticatedUsers"
} 