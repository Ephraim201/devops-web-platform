output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.network.private_subnet_ids
}

output "app_security_group_id" {
  description = "ID del Security Group de la aplicacion"
  value       = module.network.app_security_group_id
}

output "github_actions_role_arn" {
  description = "ARN del IAM Role utilizado por GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}