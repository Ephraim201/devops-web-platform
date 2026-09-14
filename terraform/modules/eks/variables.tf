variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subredes privadas donde se desplegará EKS"
  type        = list(string)
}