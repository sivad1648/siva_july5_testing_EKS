resource "aws_eks_node_group" "my-worker-node-group" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.node_group_name}"
  node_role_arn   = aws_iam_role.My_worker_nodes.arn
  subnet_ids      = [var.subnet_id_1, var.subnet_id_2]
  instance_types   = [var.instance_type]
  #ami_type =      "${var.instance_ami}"
  #count           = "${var.instances}"


  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

#EKS can't directly set the "Name" tag, so we use the autoscaling_group_tag resource.

/*resource "aws_autoscaling_group_tag" "my-worker-node-group" {
  for_each = toset(
    [for asg in flatten(
      [for resources in aws_eks_node_group.my-worker-node-group.resources : resources.autoscaling_groups]
    ) : asg.name]
  )

  autoscaling_group_name = each.value
  #autoscaling_group_name = "${var.node_group_name}".value

  tag {
    key   = "Name"
    value = "eks_node_group"
    propagate_at_launch = true
  }

  depends_on = [
    aws_iam_role.My_worker_nodes,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.EC2InstanceProfileForImageBuilderECRContainerBuilds,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,

  ]
}*/

/*
locals{
...
  asg_tag_list = flatten([
      for node_group_key, node_group in var.node_groups: [
        for tag in lookup(node_group, "asg_tags", []): {
          node_group_key = node_group_key
          key = tag.key
          value = tag.value
          propagate_at_launch = tag.propagate_at_launch
        }
      ]
    ])
...
}

resource "aws_autoscaling_group_tag" "tag" {
  count = length(local.asg_tag_list)

  autoscaling_group_name = module.eks.node_groups[local.asg_tag_list[count.index].node_group_key].resources[0].autoscaling_groups[0].name

  tag {
    key   = local.asg_tag_list[count.index].key
    value = local.asg_tag_list[count.index].value
    propagate_at_launch = local.asg_tag_list[count.index].propagate_at_launch
  }
}*/
