output "bucket_name" {
  description = "The name of the bucket"
  value       = google_storage_bucket.static_web.name
}

output "bucket_url" {
  description = "The self-link of the bucket"
  value       = google_storage_bucket.static_web.self_link
}

output "website_endpoint" {
  description = "The website endpoint of the bucket"
  value       = google_storage_bucket.static_web.self_link
} 