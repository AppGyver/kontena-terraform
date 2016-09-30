variable "name" {}
variable "count" { default = 1 }

variable "aws_ec2_virtualization_type" { default = "PV" }
variable "aws_ec2_ami_id_by_virtualization_type" {
  default = {
    "HVM" = "ami-e3d6ab90",
    "PV" = "ami-58d5a82b"
  }
}

variable "aws_ec2_instance_type" { default = "t1.micro" }
variable "aws_ec2_associate_public_ip_address" { default = false }
variable "aws_key_pair_name" {}
variable "aws_availability_zone" { default = "" }
variable "aws_vpc_subnet_ids" {}
variable "aws_vpc_security_group_ids" {}

variable "aws_ec2_root_block_device_volume_type" { default = "gp2" }
variable "aws_ec2_root_block_device_volume_size" { default = 10 }
variable "aws_ec2_root_block_device_delete_on_termination" { default = true }

variable "aws_ec2_user_data" { default = "" }
