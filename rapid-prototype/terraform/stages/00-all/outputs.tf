output "static_web_url" {
  description = "The URL of the static web bucket"
  value       = module.static_web.website_endpoint
}

output "backend_url" {
  description = "The URL of the Cloud Run service"
  value       = module.node_backend.service_url
}

output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = module.load_balancer.ip_address
}

output "load_balancer_url" {
  description = "The URL of the load balancer"
  value       = module.load_balancer.url
} 