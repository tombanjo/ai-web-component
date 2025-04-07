terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_compute_global_address" "load_balancer_ip" {
  name = var.name
}

resource "google_compute_url_map" "url_map" {
  name            = var.name
  default_service = google_compute_backend_service.backend.id

  default_route_action {
    cors_policy {
      allow_credentials = true
      allow_headers    = ["*"]
      allow_methods    = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
      allow_origins    = ["*"]  # You can restrict this to specific origins if needed
      expose_headers   = ["Content-Length", "Content-Type"]
    }
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = []  # Google will automatically manage the SSL certificate
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "${var.name}-forwarding-rule"
  target     = google_compute_target_https_proxy.https_proxy.id
  port_range = "443"
  ip_address = google_compute_global_address.load_balancer_ip.address
}

resource "google_compute_backend_service" "backend" {
  name                  = var.name
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30
  enable_cdn            = false

  backend {
    group = var.backend_service_group
  }

  iap {
    oauth2_client_id     = var.iap_client_id
    oauth2_client_secret = var.iap_client_secret
  }
} 