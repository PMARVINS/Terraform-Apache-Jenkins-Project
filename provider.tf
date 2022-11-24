# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-2"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  

  tags = {
    Name = "main"
  }
}