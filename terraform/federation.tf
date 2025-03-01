
# example without existing KSA
module "workload_identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "~> 36.0"

  project_id          = var.project_id
  name                = var.federated_sa
  namespace           = "app"
  use_existing_k8s_sa = false
}

