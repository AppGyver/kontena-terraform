output "public_dns" {
  value = ["${aws_instance.mod.*.public_dns}"]
}

output "private_dns" {
  value = ["${aws_instance.mod.*.private_dns}"]
}
