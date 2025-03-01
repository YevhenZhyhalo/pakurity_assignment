
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

provider "helm" {

  kubernetes {
    host                   = module.gke.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)

  ignore_annotations = [
    "^iam.gke.io\\/.*"
  ]
}