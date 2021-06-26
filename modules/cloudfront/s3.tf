resource "aws_s3_bucket" "contents" {
  bucket = "${var.prefix}-s3-cloudfront-contents"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "contents" {
  bucket = aws_s3_bucket.contents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.contents.id
  key    = "index.html"
  source = "${path.module}/resources/s3/index.html"
}

resource "aws_s3_bucket_object" "error_html" {
  bucket = aws_s3_bucket.contents.id
  key    = "error/error.html"
  source = "${path.module}/resources/s3/error/error.html"
}

resource "aws_s3_bucket_object" "maintenance_html" {
  bucket = aws_s3_bucket.contents.id
  key    = "error/maintenance.html"
  source = "${path.module}/resources/s3/error/maintenance.html"
}
