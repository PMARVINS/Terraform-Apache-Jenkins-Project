# Configure RDS 
resource "aws_db_instance" "rds" {
  allocated_storage    = 15
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "paulmarvin"
  password             = "adminpassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = true
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  db_subnet_group_name = aws_db_subnet_group.dbsubnetgroup.name
}


resource "aws_db_subnet_group" "dbsubnetgroup" {
  name       = "dbsubgroup"
  subnet_ids = [aws_subnet.SubnetE.id, aws_subnet.SubnetF.id]

  tags = {
    Name = "My DB subnet group"
  }
}