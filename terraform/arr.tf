resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "docker-repo"
  description   = "Docker repository"
  format        = "DOCKER"
}