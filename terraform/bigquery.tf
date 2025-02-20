module "data_warehouse" {
  source  = "terraform-google-modules/bigquery/google//modules/data_warehouse"
  version = "~> 9.0"

  project_id          = var.project_id
  region              = var.region
  deletion_protection = false
  force_destroy       = true
}