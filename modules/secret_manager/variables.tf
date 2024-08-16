variable "environment" {
  description = "Environment name"
  type        = string
}

variable "env_files" {
  description = "Map of environment names to S3 file ARNs for environment files"
  type        = map(string)
}
