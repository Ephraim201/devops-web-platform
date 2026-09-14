variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad utilizadas por la VPC"
  type        = list(string)
}

variable "project_name" {
  description = "Nombre del proyecto utilizado para nombrar los recursos"
  type        = string
}