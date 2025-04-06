terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

# Create a service account for GitHub Actions
resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = "GitHub Actions Service Account"
  description  = "Service account used by GitHub Actions for ${var.github_repository}"
}

# Create a Workload Identity Pool
resource "google_iam_workload_identity_pool" "github" {
  project                       = var.project_id
  workload_identity_pool_id     = var.workload_identity_pool_id
  display_name                 = "GitHub Actions Pool"
  description                 = "Identity pool for GitHub Actions"
}

# Create a Workload Identity Pool Provider for GitHub
resource "google_iam_workload_identity_pool_provider" "github" {
  project                                    = var.project_id
  workload_identity_pool_id                 = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id        = var.workload_identity_pool_provider_id
  display_name                             = "GitHub Actions Provider"
  description                             = "OIDC identity pool provider for GitHub Actions"
  
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
    "attribute.sha"        = "assertion.sha"
    "attribute.environment" = "assertion.environment"
    "attribute.job_workflow_ref" = "assertion.job_workflow_ref"
  }

  attribute_condition = "assertion.repository == \"${var.github_repository}\""

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Grant the service account access to the Workload Identity Pool
resource "google_service_account_iam_member" "github_actions_identity" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_repository}"
}

# Grant admin privileges to the service account
resource "google_project_iam_member" "github_actions_admin" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
} 