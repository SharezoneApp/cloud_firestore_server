terraform {
  # Can only be used after bootstrapping the gcs bucket locally
  backend "gcs" {
    bucket  = "fstore-server-dart-pkg-tf-state-storage"
    prefix  = "terraform/state"
  }
}

provider "google" {
  // Application default credentials via `gcloud auth application-default login`
}
provider "google-beta" {
  /*
    We use the Application Default Credentials but impersonate a service account because currently you can't create
    a Firebase project with just the default credentials (with no service account credentials impersonation).
    This Error comes when not impersonating a service account:
    ```
    Error creating Project: googleapi: Error 403: 
    Your application has authenticated using end user credentials from the Google Cloud SDK or Google Cloud Shell which are not supported by the firebase.googleapis.com. 
    We recommend configuring the billing/quota_project setting in gcloud or using a service account through the auth/impersonate_service_account setting. 
    For more information about service accounts and how to use them in your application, see https://cloud.google.com/docs/authentication/.
    ```
    Before the service account can be impersonated you will need to create the bootstrap resources with just the application default credentials.
    See below.
  */
  impersonate_service_account = "terraform@firestore-server-dart-pkg.iam.gserviceaccount.com"
}

# Bootstrap before the impersonated service account can be used and thus the Firebase project can be created:

variable "gcp-org-id" {
  sensitive = true
  type      = string
}

variable "gcp-billing-acc-id" {
  sensitive = true
  type      = string
}

resource "google_service_account" "terraform-service-account" {
  account_id = "terraform"
  project    = google_project.my_project.project_id
}

resource "google_project" "my_project" {
  name            = "Dart Firestore Server Package"
  project_id      = "firestore-server-dart-pkg"
  org_id          = var.gcp-org-id
  billing_account = var.gcp-billing-acc-id
}

output "service-account-id" {
  value = google_service_account.terraform-service-account.email
}

resource "google_project_iam_binding" "terraform-account-iam" {
  project = google_project.my_project.project_id
  role    = "roles/editor"
  members = ["serviceAccount:${google_service_account.terraform-service-account.email}"]
}

# Needed so that I can do stuff when I use the impersonated service account.
# If using this terraform config for the first time this needs to be enabled 
# before you can actually use the service account and create the firebase project
# and the Firestore DB.
resource "google_project_service" "enable_cloud_resource_manager_api" {
  project                    = google_project.my_project.project_id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "enable_serviceusage_api" {
  project                    = google_project.my_project.project_id
  service                    = "serviceusage.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "enable_iam_api" {
  project                    = google_project.my_project.project_id
  service                    = "iam.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_firebase_api" {
  project                    = google_project.my_project.project_id
  service                    = "firebase.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_appengine_api" {
  project                    = google_project.my_project.project_id
  service                    = "appengine.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "enable_billing_api" {
  project                    = google_project.my_project.project_id
  service                    = "cloudbilling.googleapis.com"
  disable_dependent_services = true
}

# Used to store Terraform state
resource "google_storage_bucket" "state-store" {
  project = google_project.my_project.project_id
  name    = "fstore-server-dart-pkg-tf-state-storage"
  # Google Free Tier location
  location = "us-east1"
}


# -- End Bootstrap

# Needs impersonated account.
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.my_project.project_id
}

# Had errors here with an impersonated account (no permissions) but it worked when using application default credentials.
# Did only show via UI in Firebase when I added a document via the gcloud console "Firestore"-tab (not Firebase).
resource "google_app_engine_application" "firestore" {
  project = google_project.my_project.project_id
  # As GitHub Actions run in the US I will put Firestore there too.
  location_id   = "us-west3"
  database_type = "CLOUD_FIRESTORE"
}
