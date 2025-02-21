    resource "google_bigquery_dataset" "dataset" {
        dataset_id = "Trivy"
        friendly_name = "trivy"
        description = "This is trivy report"
        location = "EU"

    }


    resource "google_logging_project_sink" "log_sink" {
    name        = "log_sink"
    description = "log sink for trivy"
    destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/${google_bigquery_dataset.dataset.dataset_id}"
    filter      = "resource.labels.cluster_name=${var.cluster_name}"

    # Whether or not to create a unique identity associated with this sink.
    unique_writer_identity = true

    bigquery_options {
    use_partitioned_tables = true

    # options associated with big query
    # Refer to the resource docs for more information on the options you can use
  }
}


// Grant the role of BigQuery Data Editor
resource "google_project_iam_binding" "log-writer-bigquery" {
  role = "roles/bigquery.dataEditor"
  project = var.project_id

  members = [
    google_logging_project_sink.log_sink.writer_identity,
  ]
}