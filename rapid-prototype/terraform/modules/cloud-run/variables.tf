variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "region" {
  description = "The region to deploy the service to"
  type        = string
  default     = "us-central1"
}

variable "image" {
  description = "The container image to deploy"
  type        = string
}

variable "project_id" {
  description = "The ID of the project"
  type        = string
} 