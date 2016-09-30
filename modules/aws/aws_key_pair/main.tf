resource "aws_key_pair" "mod" {
  key_name = "${var.name}"
  public_key = "${var.public_key}"
}
