variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources to"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the static web bucket"
  type        = string
}

variable "location" {
  description = "The location of the bucket"
  type        = string
  default     = "US"
}

variable "allowed_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = ["*"]
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "node-backend"
}

variable "backend_image" {
  description = "The container image for the backend"
  type        = string
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "node-backend-lb"
} 