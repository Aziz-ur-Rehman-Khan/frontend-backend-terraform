# variables.tf

variable "ecr_name" {
  description = "Name of the ECR repository"
}

variable "force_delete" {
  description = "Whether to enable force deletion of the repository"
  default     = false
}

variable "untagged_retention_days" {
  description = "Number of days to retain untagged images"
  default     = 14
}

variable "tagged_retention_images" {
  description = "Number of images to retain with specific tags"
  default     = 30
}

variable "tag_prefixes" {
  description = "List of tag prefixes to retain images"
  type        = list(string)
  default     = ["updated", "staging", "production"]
}
