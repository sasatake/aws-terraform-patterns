variable "prefix" {
  type = map
  default = {
    pascal = "ServerlessExpress"
    kebab  = "serverless-express"
    snake  = "serverless_express"
  }
}
