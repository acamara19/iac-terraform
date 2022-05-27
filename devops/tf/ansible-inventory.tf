resource "local_file" "ansible_inventory" {
  # content = join("\n", [for host in linode_instance.cfe-pyapp.*: "${host.ip_address}"])
  content  = templatefile("${local.templates_dir}/ansible-inventory.tpl", { hosts = [for host in linode_instance.web-pyapp.* : "${host.ip_address}"] })
  filename = "${local.devops_dir}/ansible/inventory.ini"
}