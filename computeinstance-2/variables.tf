variable "list" { default = ["1", "2", "3"] }

variable "machinetype" {
  default = "f1-micro"
}
variable "imagename" {
#  default = "debian-cloud/debian-9"
  default = "centos-cloud/centos-7"
  #  type= map
  #  default = {
  #    "dev" = "debian-cloud/debian-9"
  #    "prod" = "somethingelse"
  #  }
}
variable "networkname" {
  default = "default"
}
variable "name" {
  default = "machine1"
}