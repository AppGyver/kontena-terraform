variable "version" { default = "latest" }
variable "peer_interface" { default = "eth0" }
variable "master_uri" {}
variable "token" {}

data "template_file" "node" {
  template = "${file("modules/coreos/node/cloud-config.yml")}"

  vars {
    version = "${var.version}"
    peer_interface = "${var.peer_interface}"
    master_uri = "${var.master_uri}"
    token = "${var.token}"
  }
}

output "rendered" {
  value = "${data.template_file.node.rendered}"
}
