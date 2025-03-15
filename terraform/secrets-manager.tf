locals {
  koloni_api_env = jsondecode(data.aws_secretsmanager_secret_version.koloni-api.secret_string)
}

data "aws_secretsmanager_secret_version" "koloni-api" {
  secret_id = "${var.environment}/koloni-api"
}
