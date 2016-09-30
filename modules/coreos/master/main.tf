variable "version" { default = "latest" }
variable "mongodb_uri" {}
variable "vault_iv" {
  default = "a426d8b69f5601cb32cdd169af9e0d3c714cab4e2069b364acd36e41b637f1bef1b731611b94192e489b110cf884b5e4"
}
variable "vault_key" {
  default = "34dfe1d3fa387444e303167182a313f64d0cd93d8d3ce5522e2e29a650e7011b1fafc4a4e5469f9de55cd5ef40f3e085"
}
variable "max_threads" {
  default = "1"
}
variable "web_concurrency" {
  default = "1"
}

data "template_file" "master" {
  template = "${file("modules/coreos/master/cloud-config.yml")}"

  vars {
    mongodb_uri = "${var.mongodb_uri}"
    version = "${var.version}"
    vault_iv = "${var.vault_iv}"
    vault_key = "${var.vault_key}"
    max_threads = "${var.max_threads}"
    web_concurrency = "${var.web_concurrency}"
  }
}

output "rendered" {
  value = "${data.template_file.master.rendered}"
}
