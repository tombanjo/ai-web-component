output "client_id" {
  description = "The IAP client ID"
  value       = google_iap_client.project_client.client_id
}

output "client_secret" {
  description = "The IAP client secret"
  value       = google_iap_client.project_client.secret
  sensitive   = true
} 