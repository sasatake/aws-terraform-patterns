resource "aws_api_gateway_rest_api" "serverless_api" {
  name        = "${var.prefix.kebab}-api"
  description = "my serverless api"
}

resource "aws_api_gateway_resource" "serverless_api" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "serverless_api_lambda" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.serverless_api.id
  http_method   = "ANY"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "serverless_api_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id             = aws_api_gateway_resource.serverless_api.id
  http_method             = aws_api_gateway_method.serverless_api_lambda.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.serverless_api.invoke_arn
}

resource "aws_api_gateway_method" "serverless_api_cors" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.serverless_api.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "serverless_api_cors" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.serverless_api.id
  http_method = aws_api_gateway_method.serverless_api_cors.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "serverless_api_cors" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.serverless_api.id
  http_method = aws_api_gateway_method.serverless_api_cors.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_integration_response" "serverless_api_cors" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  resource_id = aws_api_gateway_resource.serverless_api.id
  http_method = aws_api_gateway_method.serverless_api_cors.http_method
  status_code = 200
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Requested-With'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'"
  }
}

resource "aws_api_gateway_deployment" "serverless_api_dev" {
  depends_on = [
    aws_api_gateway_integration.serverless_api_lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  stage_name  = "dev"

  lifecycle {
    create_before_destroy = true
  }
}

