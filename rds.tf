resource "aws_db_subnet_group" "default" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name = "${var.app_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  identifier             = "${var.app_name}-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.39"
  instance_class         = "db.t4g.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "${var.app_name}-db"
  }
}