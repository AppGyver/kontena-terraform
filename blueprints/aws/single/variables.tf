variable "aws_profile" {}
variable "aws_region" {}
variable "ssh_public_key" {}

variable "name" { default = "kontena-single" }

variable "kontena_grid_token" { default = "not-known-yet" }

variable "aws_vpc_cidr" { default = "10.0.0.0/16" }
variable "aws_vpc_subnets_private" {
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}
variable "aws_vpc_subnets_public" {
  default = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
}
variable "aws_region_availability_zones" {
  default = ["a","b","c"]
}
