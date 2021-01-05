provider "google" {
  // Application Default Credentials
}

variable "gcp-org-id" {
  sensitive = true
  type      = string
}

resource "google_project" "my_project" {
  name       = "Dart Firestore Server Package"
  project_id = "firestore-server-dart-pkg"
  org_id     = var.gcp-org-id
}
