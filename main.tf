# use data source to get all avalablility zones in region
#data "aws_availability_zones" "available_zones" = "{eu-west-2}"


# Configure Public subnet A
resource "aws_subnet" "SubnetA"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Main"
  }
}

# Configure Public subnet B
resource "aws_subnet" "SubnetB"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}

# Configure Private subnet C
resource "aws_subnet" "SubnetC"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}

# Configure Private subnet D
resource "aws_subnet" "SubnetD"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}

# Configure Private Data subnet E
resource "aws_subnet" "SubnetE"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}

# Configure Private subnet F
resource "aws_subnet" "SubnetF"{
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}


#Public Route tables
resource "aws_route_table" "publicroutetable" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Main"
  }
}

#Private Route tables
resource "aws_route_table" "privateroutetable" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Main"
  }
}


# Public route table assocation
resource "aws_route_table_association" "rtassociationpubA" {
  subnet_id      = aws_subnet.SubnetA.id
  route_table_id = aws_route_table.publicroutetable.id
}


resource "aws_route_table_association" "rtassociationpubB" {
  subnet_id      = aws_subnet.SubnetB.id
  route_table_id = aws_route_table.publicroutetable.id
}

# Private route table Association 
resource "aws_route_table_association" "rtassociationpubC" {
  subnet_id      = aws_subnet.SubnetC.id
  route_table_id = aws_route_table.privateroutetable.id
}


resource "aws_route_table_association" "rtassociationpubD" {
  subnet_id      = aws_subnet.SubnetD.id
  route_table_id = aws_route_table.privateroutetable.id
}


# Configure Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}

# Associate IGW with public route table
resource "aws_route" "igw-route" {
  route_table_id            = aws_route_table.publicroutetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
}

# Provision Elastic IP
resource "aws_eip" "eip" {
  vpc = true
}   


# Provision Nat Gateway
resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.SubnetC.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.igw.id]
}

# Associate Natgateway with private route table
resource "aws_route" "nat-route" {
  route_table_id            = aws_route_table.privateroutetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_nat_gateway.natgateway.id
}