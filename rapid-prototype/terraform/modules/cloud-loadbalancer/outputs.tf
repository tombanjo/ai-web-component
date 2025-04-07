output "ip_address" {
  description = "The IP address of the load balancer"
  value       = google_compute_global_address.load_balancer_ip.address
}

output "url" {
  description = "The URL of the load balancer"
  value       = "https://${google_compute_global_address.load_balancer_ip.address}"
}

output "backend_service_name" {
  description = "The name of the backend service"
  value       = google_compute_backend_service.backend.name
} 