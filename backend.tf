# resource "aws_s3_bucket" "terraform_state" {
#   bucket = local.bucket_name

#   lifecycle {
#     prevent_destroy = true
#   }
# }


# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = local.is_backend_s3_version_enabled
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = local.sse_algorithm
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket                  = aws_s3_bucket.terraform_state.id
#   block_public_acls       = local.block_public_acls
#   block_public_policy     = local.block_public_policy
#   ignore_public_acls      = local.ignore_public_acls
#   restrict_public_buckets = local.restrict_public_buckets
# }

# resource "aws_dynamodb_table" "terraform_state" {
#   name                        = local.dynamodb_table_name
#   billing_mode                = local.dynamodb_billing_mode
#   deletion_protection_enabled = local.deletion_protection_enabled
#   hash_key                    = "LockID"
#   attribute {
#     name = "LockID"
#     type = local.dynamodb_hash_data_type
#   }
# }
