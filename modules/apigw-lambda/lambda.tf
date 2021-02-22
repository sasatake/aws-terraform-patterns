resource "aws_lambda_function" "serverless_api" {
  function_name = "${var.prefix.kebab}-function-serverless-api"
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  role          = aws_iam_role.lambda_execution.arn
  filename      = "${path.module}/files/lambda/package.zip"
}
