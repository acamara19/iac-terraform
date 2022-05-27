resource "linode_nodebalancer" "webapp_nb" {
  label                = "iac-terraform-nodebalancer"
  region               = var.region
  client_conn_throttle = 20
  depends_on = [
    linode_instance.web-pyapp
  ]
}

resource "linode_nodebalancer_config" "webapp_nb_config" {
  nodebalancer_id = linode_nodebalancer.webapp_nb.id
  port            = 80
  protocol        = "http"
  check           = "http"
  check_path      = "/"
  check_interval  = 35
  check_attempts  = 15
  check_timeout   = 30
  stickiness      = "http_cookie"
  algorithm       = "source"
}

resource "linode_nodebalancer_node" "pycfe_nb_node" {
  count           = var.linode_instance_count
  nodebalancer_id = linode_nodebalancer.webapp_nb.id
  config_id       = linode_nodebalancer_config.webapp_nb_config.id
  label           = "iac_node_webapp_${count.index + 1}"
  address         = "${element(linode_instance.web-pyapp.*.private_ip_address, count.index)}:80"
  weight          = 50
  mode            = "accept"
}