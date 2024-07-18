
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "prod-env-9949" {
  bucket = "prod-env-9949"

  tags = {
    Name = "prod-env-9949"
  }
}

resource "aws_s3_bucket_versioning" "prod-env-9949-versioning" {
  bucket = aws_s3_bucket.prod-env-9949.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "prod-env-9949-lifecycle" {
  bucket = aws_s3_bucket.prod-env-9949.id

  rule {
    id      = "prod-env-9949-rule"
    status  = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

