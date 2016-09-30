output "master_public_dns" {
  value = "${element(module.master.public_dns, 0)}"
}
output "master_private_dns" {
  value = "${element(module.master.private_dns, 0)}"
}

output "mongo_public_dns" {
  value = "${element(module.mongo.public_dns, 0)}"
}
output "mongo_private_dns" {
  value = "${element(module.mongo.private_dns, 0)}"
}

output "nodes_public_dns" {
  value = "${module.nodes.public_dns}"
}
output "nodes_private_dns" {
  value = "${module.nodes.private_dns}"
}
