output "config" {
    value = "${pathexpand("~/.kube/${var.cluster_name}/config")}"
}
