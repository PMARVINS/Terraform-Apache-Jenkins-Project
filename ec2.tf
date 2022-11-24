# configure Instances with YAML script #install_apache.sh

resource "aws_instance" "Instance-1" {
  ami                    = "ami-06672d07f62285d1d"
  instance_type          = "t2.micro"
  key_name               = "Omegakey.name"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = "aws_subnet.SubnetA.id"
  user_data              = data.template_file.web-userdata.rendered
  availability_zone      = "eu-west-2b"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



resource "aws_instance" "Instance-2" {
  ami                    = "ami-06672d07f62285d1d"
  instance_type          = "t2.micro"
  key_name               = "Omegakey.name"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = "aws_subnet.SubnetB.id"
  user_data              = "../install_apache.sh"
  availability_zone      = "eu-west-2b"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



data "template_file" "web-userdata" {
    template = file("install_apache.sh")
}