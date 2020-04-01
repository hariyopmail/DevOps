

provider "google" {
  project     = "agb-gcp2"
  region      = "us-east4-b"
  credentials = file("/home/agbruneau/Documents/credentials/AGB-GCP2-Compute-Engine.json")
}