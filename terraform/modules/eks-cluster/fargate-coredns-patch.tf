locals {
  kubectl_binary_url = "https://storage.googleapis.com/kubernetes-release/release/v1.26.0/bin/linux/amd64/kubectl"
}

# Patch EKS cluster to remove EC2 type annotation as this conflicts with Fargate.
resource "null_resource" "k8s-patch" {
  triggers = {
    endpoint         = aws_eks_cluster.default.endpoint
    ca_crt           = base64decode(aws_eks_cluster.default.certificate_authority[0].data)
    token            = data.aws_eks_cluster_auth.default.token
    load_config_file = false
  }

  # Get kubectl binary before proceeding
  provisioner "local-exec" {
    command = "wget ${local.kubectl_binary_url} && chmod +x ./kubectl"
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]

    command = <<EOT
cat >/tmp/ca.crt <<EOF
${base64decode(aws_eks_cluster.default.certificate_authority[0].data)}
EOF
./kubectl \
  --server="${aws_eks_cluster.default.endpoint}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${data.aws_eks_cluster_auth.default.token}" \
  patch deployment coredns \
  -n ${local.kube_namespace} --type json \
  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
EOT
  }

  lifecycle {
    ignore_changes = [triggers]
  }

  depends_on = [
    data.aws_eks_cluster_auth.default,
    aws_eks_fargate_profile.kube-system
  ]
}
