resource "aws_api_gateway_rest_api" "serverless_api" {
  name        = "${var.prefix.kebab}-api"
  description = "my serverless api"
}

resource "aws_api_gateway_resource" "serverless_api" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "serverless_api" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.serverless_api.id
  http_method   = "ANY"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "serverless_api" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id             = aws_api_gateway_resource.serverless_api.id
  http_method             = aws_api_gateway_method.serverless_api.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.serverless_api.invoke_arn
}

resource "aws_api_gateway_deployment" "serverless_api_dev" {
  depends_on = [
    aws_api_gateway_integration.serverless_api,
  ]

  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  stage_name  = "dev"

  lifecycle {
    create_before_destroy = true
  }
}

