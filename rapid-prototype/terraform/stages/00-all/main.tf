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
  region  = var.region
}

# Enable required Google Cloud APIs
module "apis" {
  source = "../../modules/cloud-apis"

  project_id = var.project_id
}

# Cloud Storage for static web hosting
module "static_web" {
  source = "../../modules/cloud-storage"

  project_id       = var.project_id
  bucket_name      = var.bucket_name
  location         = var.location
  allowed_origins  = var.allowed_origins

  depends_on = [module.apis]
}

# Cloud Run for Node.js backend
module "node_backend" {
  source = "../../modules/cloud-run"

  project_id   = var.project_id
  service_name = var.service_name
  region       = var.region
  image        = var.backend_image

  depends_on = [module.apis]
}

# IAP Configuration
module "iap" {
  source = "../../modules/cloud-iap"

  project_id           = var.project_id
  backend_service_name = var.load_balancer_name

  depends_on = [module.apis]
}

# Cloud Load Balancer
module "load_balancer" {
  source = "../../modules/cloud-loadbalancer"

  project_id           = var.project_id
  name                = var.load_balancer_name
  backend_service_group = module.node_backend.service_url
  iap_client_id        = module.iap.client_id
  iap_client_secret    = module.iap.client_secret

  depends_on = [module.apis]
} 