resource "aws_cognito_user_pool" "api_auth" {
  name = "${var.prefix.kebab}-cogup"

  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    name                     = "email"
    required                 = true
    mutable                  = false
    string_attribute_constraints {
      min_length = 0
      max_length = 128
    }
  }

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = false
    require_uppercase                = false
    temporary_password_validity_days = 7
  }
}

resource "aws_cognito_user_pool_client" "app" {
  name                   = "app_client"
  user_pool_id           = aws_cognito_user_pool.api_auth.id
  refresh_token_validity = 30
}

resource "aws_cognito_user_pool_client" "admin" {
  name                   = "admin_client"
  user_pool_id           = aws_cognito_user_pool.api_auth.id
  refresh_token_validity = 30
  explicit_auth_flows    = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}


resource "aws_cognito_identity_pool" "api_auth" {
  identity_pool_name               = "${var.prefix.snake}_cogip"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.app.id
    provider_name           = aws_cognito_user_pool.api_auth.endpoint
    server_side_token_check = false
  }

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.admin.id
    provider_name           = aws_cognito_user_pool.api_auth.endpoint
    server_side_token_check = false
  }

}

resource "aws_cognito_identity_pool_roles_attachment" "api_auth" {
  identity_pool_id = aws_cognito_identity_pool.api_auth.id

  roles = {
    "authenticated"   = aws_iam_role.idp_auth.arn
    "unauthenticated" = aws_iam_role.idp_unauth.arn
  }
}
