

provider "google" {
  project     = "agb-gcp2"
  region      = "us-east1-b"
  credentials = file("/home/agbruneau/Documents/credentials/AGB-GCP2-Compute-Engine.json")
}