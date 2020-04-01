
variable "path" { default = "/home/agbruneau/Documents/credentials" }

provider "google" {
  project     = "agb-gcp2"
  region      = "us-east4"
  credentials = file("${var.path}/AGB-GCP2-Compute-Engine.json")
}