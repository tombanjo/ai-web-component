variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region for deployment"
  type        = string
}

variable "service_name" {
  description = "The container image for the service"
  type        = string
}

variable "cors_origin" {
  description = "The CORS origins for the Cloud Run service"
  type        = string
}