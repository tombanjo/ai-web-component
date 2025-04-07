variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "backend_service_group" {
  description = "The backend service group"
  type        = string
}

variable "iap_client_id" {
  description = "The IAP client ID"
  type        = string
}

variable "iap_client_secret" {
  description = "The IAP client secret"
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "The ID of the project"
  type        = string
} 