variable "name" {}

resource "null_resource" "grid" {
  provisioner "local-exec" {
      command = "kontena grid show ${var.name}"
  }
}
