# resource to create the bigquery dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "foo"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"

  access {
    role          = "OWNER"
    user_by_email = ${var.service_account}
    }
  }
}
 

# resource to create the tables in the dataset
resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "bar"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF

}