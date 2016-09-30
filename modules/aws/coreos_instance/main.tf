resource "aws_instance" "mod" {
  count = "${var.count}"

  availability_zone = "${var.aws_availability_zone}"

  ami = "${lookup(var.aws_ec2_ami_id_by_virtualization_type, var.aws_ec2_virtualization_type)}"
  instance_type = "${var.aws_ec2_instance_type}"

  subnet_id = "${element(split(",", var.aws_vpc_subnet_ids),count.index)}"
  vpc_security_group_ids = ["${split(",", var.aws_vpc_security_group_ids)}"]
  associate_public_ip_address = "${var.aws_ec2_associate_public_ip_address}"

  key_name = "${var.aws_key_pair_name}"

  root_block_device {
    volume_type = "${var.aws_ec2_root_block_device_volume_type}"
    volume_size = "${var.aws_ec2_root_block_device_volume_size}"
    delete_on_termination = "${var.aws_ec2_root_block_device_delete_on_termination}"
  }

  tags {
    Name = "${var.name}-${count.index}"
  }

  user_data = "${var.aws_ec2_user_data}"
}
