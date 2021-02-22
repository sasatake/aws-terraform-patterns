resource "aws_iam_role" "lambda_execution" {
  name               = "${var.prefix.pascal}LambdaExecutionRole"
  assume_role_policy = file("${path.module}/templates/iam/lambda/execution_assume_role_policy.json")
}

resource "aws_iam_role" "idp_auth" {
  name = "${var.prefix.pascal}IdentityPoolAuthRole"
  assume_role_policy = templatefile(
    "${path.module}/templates/iam/cognito-identity/assume_role_policy.json",
    { aud = aws_cognito_identity_pool.api_auth.id, amr = "authenticated" }
  )
}

resource "aws_iam_role" "idp_unauth" {
  name = "${var.prefix.pascal}IdentityPoolUnAuthRole"
  assume_role_policy = templatefile(
    "${path.module}/templates/iam/cognito-identity/assume_role_policy.json",
    { aud = aws_cognito_identity_pool.api_auth.id, amr = "unauthenticated" }
  )
}

resource "aws_iam_policy" "invoke_api" {
  name = "${var.prefix.pascal}InvokeServerlessAPIPolicy"
  policy = templatefile(
    "${path.module}/templates/iam/cognito-identity/invoke_api_policy.json",
    { api_arn = "${aws_api_gateway_deployment.serverless_api_dev.execution_arn}/*/*/*" }
  )
}

resource "aws_iam_role_policy_attachment" "idp_auth_invoke_api" {
  role       = aws_iam_role.idp_auth.name
  policy_arn = aws_iam_policy.invoke_api.arn
}

