
provider "google" {
  project = var.project_id
  region  = var.region
}


# Remote backend
terraform {
  backend "gcs" {
    bucket = "63218c1cb925ba9e-terraform-remote-backend-state"
    prefix = "main/terraform.tfstate"
  }
}
