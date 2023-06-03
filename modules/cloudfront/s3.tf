resource "aws_s3_bucket" "contents" {
  bucket = "${var.prefix}-s3-cloudfront-contents"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.contents.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_versioning" "contents" {
  bucket = aws_s3_bucket.contents.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "contents" {
  bucket = aws_s3_bucket.contents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "contents" {
  bucket = aws_s3_bucket.contents.id

  policy = templatefile("${path.module}/templates/s3/oai_access_policy.json.tpl",
    {
      oai_iam_arn = aws_cloudfront_origin_access_identity.contents.iam_arn,
      bucket_name = aws_s3_bucket.contents.id
    }
  )
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.contents.id
  key          = "index.html"
  source       = "${path.module}/resources/s3/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.contents.id
  key          = "error/error.html"
  source       = "${path.module}/resources/s3/error/error.html"
  content_type = "text/html"
}

resource "aws_s3_object" "maintenance_html" {
  bucket       = aws_s3_bucket.contents.id
  key          = "error/maintenance.html"
  source       = "${path.module}/resources/s3/error/maintenance.html"
  content_type = "text/html"
}
