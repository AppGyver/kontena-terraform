provider "aws" {
  profile = "${var.aws_profile}"
  region = "${var.aws_region}"
}

module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "${var.name}"

  enable_dns_hostnames = true
  enable_dns_support = true
  map_public_ip_on_launch = false

  cidr = "${var.aws_vpc_cidr}"

  public_subnets  = ["${var.aws_vpc_subnets_public}"]
  private_subnets = ["${var.aws_vpc_subnets_private}"]

  azs = "${formatlist("${var.aws_region}%s", var.aws_region_availability_zones)}"
}

module "vpc_default_security_group" {
  source = "../../../modules/aws/tf_aws_vpc_default_security_group"

  aws_vpc_id = "${module.vpc.vpc_id}"
  name = "${var.name}-default-security-group"
}

module "aws_key_pair" {
  source = "../../../modules/aws/aws_key_pair"
  name = "${var.name}"
  public_key = "${var.ssh_public_key}"
}

module "mongo_cloud_config" {
  source = "../../../modules/coreos/mongo"
}

module "mongo" {
  source = "../../../modules/aws/coreos_instance"
  name = "${var.name}-mongo"

  aws_key_pair_name = "${module.aws_key_pair.name}"
  aws_vpc_subnet_ids = "${join(",", module.vpc.public_subnets)}"
  aws_vpc_security_group_ids = "${join(",", list(module.vpc.default_security_group_id))}"

  aws_ec2_associate_public_ip_address = true

  aws_ec2_user_data = "${module.mongo_cloud_config.rendered}"
}

module "master_cloud_config" {
  source = "../../../modules/coreos/master"
  mongodb_uri = "mongodb://${module.mongo.private_dns[0]}:27017/${var.name}_master"
}

module "master" {
  source = "../../../modules/aws/coreos_instance"
  name = "${var.name}-master"

  aws_key_pair_name = "${module.aws_key_pair.name}"
  aws_vpc_subnet_ids = "${join(",", module.vpc.public_subnets)}"
  aws_vpc_security_group_ids = "${join(",", list(module.vpc.default_security_group_id))}"

  aws_ec2_associate_public_ip_address = true

  aws_ec2_user_data = "${module.master_cloud_config.rendered}"
}

module "node_cloud_config" {
  source = "../../../modules/coreos/node"

  peer_interface = "eth0"
  master_uri = "http://${module.master.private_dns[0]}"
  token = "${var.kontena_grid_token}"
}

module "nodes" {
  source = "../../../modules/aws/coreos_instance"

  count = 3
  name = "${var.name}-node"

  aws_key_pair_name = "${module.aws_key_pair.name}"
  aws_vpc_subnet_ids = "${join(",", module.vpc.public_subnets)}"
  aws_vpc_security_group_ids = "${join(",", list(module.vpc.default_security_group_id))}"

  aws_ec2_associate_public_ip_address = true

  aws_ec2_user_data = "${module.node_cloud_config.rendered}"
}
