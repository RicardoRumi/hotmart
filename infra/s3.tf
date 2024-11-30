data "aws_caller_identity" "current" {}

# Modify Account-Level Block Public Access Settings
resource "aws_s3_account_public_access_block" "this" {
  account_id = data.aws_caller_identity.current.account_id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "ricardo-rumi-frontend-bucket-name"
  # Note: Do not set the 'acl' parameter here
}

# Bucket-Level Block Public Access Settings
resource "aws_s3_bucket_public_access_block" "frontend_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Remove the Bucket ACL Resource
# resource "aws_s3_bucket_acl" "frontend_acl" {
#   bucket = aws_s3_bucket.frontend_bucket.id
#   acl    = "public-read"
# }

# Website Configuration
resource "aws_s3_bucket_website_configuration" "frontend_website" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# CORS Configuration
resource "aws_s3_bucket_cors_configuration" "frontend_cors" {
  bucket = aws_s3_bucket.frontend_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

# Bucket Policy to Allow Public Read Access
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
      }
    ]
  })
}
