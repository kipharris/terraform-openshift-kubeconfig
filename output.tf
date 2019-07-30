output "config" {
    value = "${pathexpand("~/.kube/${var.cluster_name}/config")}"
}

resource "random_id" "completed" {
    depends_on = [
        "null_resource.create_cluster_admin",
    ]
}
