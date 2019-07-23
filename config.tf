resource "null_resource" "copy_config_bastion" {
    connection {
        type = "ssh"
        user = "root"
        host = "${var.bastion_ip_address}"
        private_key = "${file(var.bastion_private_ssh_key)}"
    }

    provisioner "remote-exec" {
        when = "create"
        inline = [
            "scp ${element(var.master_private_ip,0)}:./.kube/config ."
        ]
    }
}

resource "null_resource" "copy_config_localhost" {
    connection {
        type = "ssh"
        user = "root"
        host = "${var.bastion_ip_address}"
        private_key = "${file(var.bastion_private_ssh_key)}"
    }

    provisioner "local-exec" {
        when = "create"
        command = "mkdir -p ~/.kube/${var.cluster_name} && scp -i ${var.bastion_private_ssh_key} root@${var.bastion_ip_address}:./config ~/.kube/${var.cluster_name}/",
    }

    depends_on = [
        "null_resource.copy_config_bastion"
    ]
}
