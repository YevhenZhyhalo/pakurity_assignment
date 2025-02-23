
    resource "google_bigquery_dataset" "dataset_filterd" {
        dataset_id = "Trivy_filtered"
        friendly_name = "trivy_filtered"
        description = "This is trivy report"
        location = "EU"

    }

module "dataflow-job" {
  source  = "terraform-google-modules/dataflow/google//modules/legacy"
  version = "~> 2.0"

  project_id            = var.project_id
  name                  = "bq-terraform-filter"
  on_delete             = "cancel"
  region                = var.region
  max_workers           = 1
  template_gcs_path     = "gs://dataflow-templates/latest/Word_Count"
  temp_gcs_location     = module.dataflow-bucket.name
  service_account_email = var.service_account_email
  network_name          = module.vpc.network_self_link
  subnetwork            = module.vpc.subnets_self_links[0]
  machine_type          = "n1-standard-1"

  parameters = {
    inputFile = "gs://dataflow-samples/shakespeare/kinglear.txt"
    output    = "gs://${local.gcs_bucket_name}/output/my_output"
  }
}

