variable "aws_region" {
  description = "Region de AWS donde se desplegara la infraestructura"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "devops-web-platform"
}

variable "vpc_cidr" {
  description = "Rango CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidad utilizadas por la infraestructura"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
  default     = "devops-web-platform-eks"
}