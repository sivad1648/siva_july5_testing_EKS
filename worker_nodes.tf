resource "aws_eks_node_group" "my-worker-node-group" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.node_group_name}"
  node_role_arn   = aws_iam_role.My_worker_nodes.arn
  subnet_ids      = [var.subnet_id_1, var.subnet_id_2]
  instance_types   = [var.instance_type]
  count           = "${var.instances}"


  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
