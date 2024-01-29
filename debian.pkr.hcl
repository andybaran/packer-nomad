packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "nomad" {
  ami_name              = "nomad-${var.nomad_ver}"
  instance_type         = "t2.medium"
  region                = "us-east-2"
  source_ami            = "ami-0ec3d9efceafb89e0" #debian
  ssh_username          = "admin" #debian
  force_deregister      = true
  force_delete_snapshot = true

  tags = {
    Name          = "nomad"
    purpose       = "demo"
    OS_Version    = "debian"
    Release       = "Latest"
    Base_AMI_ID   = "{{ .SourceAMI }}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
  }

  snapshot_tags = {
    Name    = "nomad"
    purpose = "demo"
  }
}

build {
  sources = ["source.amazon-ebs.nomad"]

  provisioner "file" {
    destination = "/tmp/nomad-client.hcl"
    source      = "./nomad.pkrtpl-client.hcl"
  }

    provisioner "file" {
    destination = "/tmp/nomad-server.hcl"
    source      = "./nomad.pkrtpl-server.hcl"
  }

  provisioner "file" {
    destination = "/tmp/license.hclic"
    source      = "./nomad.hclic"
  }

  provisioner "file" {
    destination = "/tmp/nomad.service"
    source      = "./nomad.service.pkrtpl"
  }

  provisioner "shell" {
    script            = "./post.sh"
    environment_vars = [
      "NOMAD_VERSION=${var.nomad_ver}",
      "OS_USER=${var.os_user}",
      "ENTERPRISE=${var.enterprise}",
    ]
  }

}
