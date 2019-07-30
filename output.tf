output "config" {
    value = "${pathexpand("~/.kube/${var.cluster_name}/config")}"
}

resource "random_id" "completed" {
    byte_length = 1
    depends_on = [
        "null_resource.create_cluster_admin",
    ]
}

resource "null_resource" "dependency" {
  triggers = {
    all_dependencies = "${join(",", var.dependencies)}"
  }
}
