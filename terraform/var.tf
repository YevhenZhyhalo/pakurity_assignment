

variable "project_id" {
  description = "The project ID to host the cluster in"
  type = string
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
  type = string
}

variable "region" {
  description = "The region to host the cluster in"
  default = "us-central1"
  type = string

}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  type = string

}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
  default     = false
}

variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
  type = string

}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
  type = string

}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  type = string

}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  type = string

}

variable "nodepool_name" {
  description = "Name for the kubernetes nodepool"
  type = string
  default = "wi-pool"
}


variable "federated_sa" {
  description = "Name for the federated workload identity SA"
  type = string
  default = "federated-workload-identity"

}

variable "service_account" {
  description = "Name for the federated workload identity SA"
  type = string
  default = "overpowereduser"

}
