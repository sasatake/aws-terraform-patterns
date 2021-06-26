{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "AWS": "${oai_iam_arn}"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${bucket_name}/*"
      }
  ]
}