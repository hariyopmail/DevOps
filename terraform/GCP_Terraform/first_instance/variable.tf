
variable "image" { default = "ubuntu-os-cloud/ubuntu-1910" }

variable "machine_type" {
  type = map
  default = {
    "development"   = "n1-standard-1"
    "certification" = "n1-standard-2"
    "production"    = "n1-standard-4"
  }
}


variable "name_count" { default = ["server1", "server2", "server3"] }