output "cluster_id" {
  description = "ID del clúster EKS"
  value       = aws_eks_cluster.main.id
}

output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "Nombre del clúster EKS"
  value       = aws_eks_cluster.main.name
}

output "node_group_name" {
  description = "Nombre del Node Group de EKS"
  value       = aws_eks_node_group.main.node_group_name
}

output "cluster_role_arn" {
  description = "ARN del IAM Role del clúster EKS"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "ARN del IAM Role de los nodos EKS"
  value       = aws_iam_role.eks_nodes.arn
}

output "cluster_arn" {
  description = "ARN del clúster EKS"
  value       = aws_eks_cluster.main.arn
}