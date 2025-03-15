resource "aws_kms_key" "koloni-db" {
  count = var.environment == "production" ? 1 : 0

  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
}
