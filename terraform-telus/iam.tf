data "google_iam_policy" "reader" {
  binding {
    role = "roles/bigquery.dataViewer"
    members = [
      "${var.service_account}
    ]
  }
}

resource "google_bigquery_table_iam_policy" "policy" {
  dataset_id = google_bigquery_table.dataset.dataset_id
  table_id = google_bigquery_table.default.table_id
  policy_data = data.google_iam_policy.reader.policy_data
}

resource "google_bigquery_table_iam_binding" "binding" {
  dataset_id = google_bigquery_table.dataset.dataset_id
  table_id = google_bigquery_table.default.table_id
  role = "roles/bigquery.dataViewer"
  members = [
      "${var.service_account}
  ]
}