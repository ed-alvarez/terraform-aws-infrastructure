resource "aws_s3_bucket" "koloni-cdn" {
  bucket = "koloni-cdn-${var.environment}"
}

resource "aws_s3_bucket_cors_configuration" "koloni-cdn" {
  bucket = aws_s3_bucket.koloni-cdn.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_acl" "koloni-cdn" {
  bucket = aws_s3_bucket.koloni-cdn.id
  acl    = "public-read"
}