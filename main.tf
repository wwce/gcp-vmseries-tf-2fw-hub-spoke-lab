# --------------------------------------------------------------------------------------------------------------------------
# Setup Terraform providers, pull the regions availability zones, and create naming prefix as local variable

terraform {}

provider "google" {
  #credentials = var.auth_file
  #project     = var.project_id
  region      = var.region
}

data "google_client_config" "current" {
}

data "google_compute_zones" "main" {
  project = data.google_client_config.current.project
  region  = var.region
}

resource "random_string" "main" {
  length      = 5
  min_lower   = 5
  special     = false
}

resource "google_project_service" "service_networking" {
  #project = var.project_id
  service                    = "compute.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

locals {
  prefix = random_string.main.result
}