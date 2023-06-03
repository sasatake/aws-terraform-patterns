{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": ["cloudfront.amazonaws.com"]
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${bucket_name}/*",
        "Condition": {
            "StringEquals": {
                "aws:SourceArn": "${cloudfront_distribution_arn}"
            }
        }
    }
  ]
}