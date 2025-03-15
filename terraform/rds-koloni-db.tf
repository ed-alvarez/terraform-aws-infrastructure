resource "aws_db_subnet_group" "default" {
  name = "rds-${var.environment}-subnet-group"

  subnet_ids = [
    module.vpc.default-public-subnet-a,
    module.vpc.default-private-subnet-a,
    module.vpc.default-public-subnet-b,
    module.vpc.default-private-subnet-b
  ]
}

resource "aws_security_group" "database" {
  name   = "rds-${var.environment}-security-group"
  vpc_id = module.vpc.aws_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "locker-db" {
  identifier     = "${var.prefix}-rds-instance-${var.environment}"
  instance_class = var.rds_instance_class

  allocated_storage     = 20
  max_allocated_storage = 50

  kms_key_id        = var.environment == "production" ? aws_kms_key.koloni-db.0.arn : null
  storage_encrypted = var.environment == "production" ? true : false

  engine         = "postgres"
  engine_version = "14.10"

  parameter_group_name    = "default.postgres14"
  backup_retention_period = 3
  backup_window           = "03:00-04:00"

  db_name  = var.rds_database_name
  username = var.rds_master_username
  password = var.rds_master_password

  publicly_accessible = var.environment == "production" ? false : true
  skip_final_snapshot = true
  apply_immediately   = true

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  db_subnet_group_name = aws_db_subnet_group.default.name

  depends_on = [
    aws_db_subnet_group.default,
    aws_security_group.database,
    aws_kms_key.koloni-db
  ]
}
