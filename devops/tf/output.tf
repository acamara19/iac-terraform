output "webapp_first_deploy" {
  value = "${linode_instance.web-pyapp.0.label} : ${linode_instance.web-pyapp.0.ip_address} - ${var.region}"
}

output "webapps" {
  value = [for host in linode_instance.web-pyapp.* : "${host.label} : ${host.ip_address}"]
}