# CREATING VPC
resource "aws_vpc" "vpc-marko" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Project VPC"
  }
}

# PUBLIC SUBNET
resource "aws_subnet" "public_subnet-marko" {
  vpc_id = aws_vpc.vpc-marko.id
  cidr_block = var.public_subnet_cidr

   
 tags = {
   Name = "Public Subnet"
 }
}

# PRIVATE SUBNET
resource "aws_subnet" "private_subnet-marko" {
  vpc_id = aws_vpc.vpc-marko.id
  cidr_block = var.private_subnet_cidr

 
tags = {
   Name = "Public Subnet"
 }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw-marko" {
  vpc_id = aws_vpc.vpc-marko.id


   tags = {
   Name = "Project VPC IG"
 }
}

# ROUTE TABLE FOR PUBLIC SUBNETS
resource "aws_route_table" "second_rt-marko" {
  vpc_id = aws_vpc.vpc-marko.id


   route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw-marko.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}

# ROUTE TABLE ASSOCIATION TO PUBLIC SUBNETS
resource "aws_route_table_association" "public_subnet_asso-marko" {
    route_table_id = aws_route_table.second_rt-marko.id 
    subnet_id = aws_subnet.public_subnet-marko.id
}

# NAT GATEWAY ZA RESURSE U PRIVATE SUBNETU ALI SE STAVLJA U PUBLIC
resource "aws_nat_gateway" "nat-marko" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet-marko.id
}

# ELASTIC IP POTREBAN ZA NAT GATEWAY
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# ROUTE TABLE ZA PRIVATE SUBNET DO NAT GATEWAYA
resource "aws_route_table" "private_rt-marko" {
  vpc_id = aws_vpc.vpc-marko.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-marko.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

