resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.EKS_cluster}"
  role_arn = aws_iam_role.my-eks-iam-role.arn

  vpc_config {
    subnet_ids = [var.subnet_id_1, var.subnet_id_2]
  }

  depends_on = [
    aws_iam_role.my-eks-iam-role,
  ]
}
