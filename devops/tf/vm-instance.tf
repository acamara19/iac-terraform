resource "linode_instance" "web-pyapp" {
  count           = var.linode_instance_count
  image           = "linode/ubuntu18.04"
  label           = "web-pyapp-${count.index + 1}"
  group           = "IaC_Terrafrom_PROJECT"
  region          = var.region
  type            = "g6-nanode-1"
  authorized_keys = [var.authorized_key]
  root_pass       = var.root_user_pw
  private_ip      = true
  tags            = ["python", "docker", "terraform"]

  provisioner "file" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    source      = "${local.project_dir}/bootstrap-docker.sh"
    destination = "/tmp/bootstrap-docker.sh"
  }

  provisioner "remote-exec" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    inline = [
      "chmod +x /tmp/bootstrap-docker.sh",
      "sudo sh /tmp/bootstrap-docker.sh",
      "mkdir -p /var/www/src/",
    ]
  }

  provisioner "file" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    source      = "${local.project_dir}/src/"
    destination = "/var/www/src/"
  }

  provisioner "file" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    source      = "${local.project_dir}/Dockerfile"
    destination = "/var/www/Dockerfile"
  }

  provisioner "file" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    source      = "${local.project_dir}/entrypoint.sh"
    destination = "/var/www/entrypoint.sh"
  }

  provisioner "file" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    source      = "${local.project_dir}/requirements.txt"
    destination = "/var/www/requirements.txt"
  }


  provisioner "remote-exec" {
    connection {
      host     = self.ip_address
      type     = "ssh"
      user     = "root"
      password = var.root_user_pw
    }
    inline = [
      "cd /var/www/",
      "docker build -f Dockerfile -t web-pyapp-via-git . ",
      "docker run --restart always -p 80:8001 -e PORT=8001 -d web-pyapp-via-git"
    ]
  }
}