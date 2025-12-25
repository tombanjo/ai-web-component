variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region for deployment"
  type        = string
  default     = "us-central1"
}

variable "cloud_run_service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "container_image" {
  description = "The container image for the Cloud Run service"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the Cloud Run service."
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}# Add your variable declarations here

variable "chat_image" {
  description = "The container image for the chat service"
  type        = string
}

variable "spa_bucket_name" {
  description = "The container image for the chat service"
  type        = string
}