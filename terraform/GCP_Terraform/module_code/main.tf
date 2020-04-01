module "instance" {
  source       = "../../virtual_machine"
  zone         = "europe-west1-a"
  machine_type = "n1-standard-2"
}

module "instance_two" {
  source       = "../../virtual_machine"
  zone         = "europe-west1-b"
  machine_type = "n1-standard-1"
}

module "bucket" {
  source      = "../../bucket"
  bucket_name = "modules-test"
}