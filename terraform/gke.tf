
locals {
  cluster_type = "regional"
}

data "google_client_config" "default" {}


module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 36.0"

  project_id               = var.project_id
  name                     = var.cluster_name
  zones                    = var.zones
  region                   = var.region
  network                  = var.network
  subnetwork               = var.subnetwork
  ip_range_pods            = var.ip_range_pods
  ip_range_services        = var.ip_range_services
  remove_default_node_pool = true
  service_account          = "create"
  node_metadata            = "GKE_METADATA"
  deletion_protection      = false
  node_pools = [
    {
      name         = var.nodepool_name
      min_count    = 1
      max_count    = 1
      auto_upgrade = true
    }
  ]
}
