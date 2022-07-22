variable "region" {
  description = "The location where the K8 is to be deployed"
  type        = string
  default     = "us-east-2"

}

variable "Iam_role" {
  description = "The name of IAM role for EKS cluster"
  type        = string
  default     = "siva-EKS-IAM-ROLE"
}

variable "EKS_cluster" {
  description = "The name of the EKS Cluster"
  type        = string
  default     = "siva-EKS-CLUSTER"
}

variable "EKS_worker" {
  description = "The name of IAM role for EKS worker nodes"
  type        = string
  default     = "siva-EKS-Worker"
}

variable "node_group_name" {
  type    = string
  default = "siva-EKS-Worker_nodes"
}

variable "instance_type" {

  default = "t2.micro"
}

variable "instances" {

  default = "3"

}

variable "subnet_id_1" {
  description = "The private subnet name"
  default = "subnet-082f55d47ff8b1b8d"
}

variable "subnet_id_2" {
  description = "The other subnet name"
  default = "subnet-096aff563e700ddd9"
}
