resource "aws_cloudfront_distribution" "contents" {
  enabled = true

  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.contents.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.contents.id
    origin_access_control_id = aws_cloudfront_origin_access_control.contents.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.contents.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  custom_error_response {
    error_code         = 403
    response_code      = 403
    response_page_path = "/error/error.html"
  }

  custom_error_response {
    error_code         = 500
    response_code      = 500
    response_page_path = "/error/error.html"
  }

  custom_error_response {
    error_code         = 502
    response_code      = 502
    response_page_path = "/error/error.html"
  }

  custom_error_response {
    error_code         = 503
    response_code      = 503
    response_page_path = "/error/maintenance.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }


}

resource "aws_cloudfront_origin_access_control" "contents" {
  name                              = "${var.prefix}-cfoac-contents"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
