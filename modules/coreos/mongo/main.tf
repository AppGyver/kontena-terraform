variable "mongo_version" { default = "3.0" }
variable "bind_ip" { default = "0.0.0.0" }

data "template_file" "mongo" {
  template = "${file("modules/coreos/mongo/cloud-config.yml")}"

  vars {
    mongo_version = "${var.mongo_version}"
    bind_ip = "${var.bind_ip}"
  }
}

output "rendered" {
  value = "${data.template_file.mongo.rendered}"
}
