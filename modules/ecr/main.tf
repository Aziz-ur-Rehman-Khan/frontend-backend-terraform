resource "aws_ecr_repository" "ecr" {
  name         = var.ecr_name
  force_delete = var.force_delete
}

resource "aws_ecr_lifecycle_policy" "ecr_image_lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name
  policy     = local.tagged_lifecycle_policy
}

