#alert policy
resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "Service Account usage"
  combiner     = "AND"
  conditions {
    display_name = "bigquery service account usage breached"
    condition_threshold {
      filter = ""metric.type=\"bigquery.googleapis.com/query/bytes_processed\" AND metric.user_labels.service_account=\"${var.service_account}\""
      duration   = "60s"
      threshold_value = "1000000000000"
      evaluation_interval = "86400s"
      alert_rule  = "AlwaysOn"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
      evaluation_missing_data = "EVALUATION_MISSING_DATA_INACTIVE"
    }
  }

  user_labels = {
    foo = "bar"
  }
}

#notification channel
resource "google_monitoring_notification_channel" "basic" {
  display_name = "bigquery service account usage"
  type         = "email"
  labels = {
    email_address = "fake_email@blahblah.com"
  }
  force_delete = false
}
