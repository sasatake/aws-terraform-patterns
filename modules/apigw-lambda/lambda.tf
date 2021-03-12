resource "aws_lambda_function" "serverless_api" {
  function_name = "${var.prefix.kebab}-function-serverless-api"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_execution.arn
  filename      = "${path.module}/files/lambda/package.zip"

  lifecycle {
    ignore_changes = [filename]
  }
}

resource "aws_lambda_permission" "serverless_api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.serverless_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.serverless_api.execution_arn}/*/*/*"
}

