resource "aws_vpc" "North_Virginia-VPC" {
  provider = aws.North_Virginia
  cidr_block = var.vpc-cidr
  tags = { Name = "${var.name-prefix}-VPC" }
}

resource "aws_subnet" "North_Virginia-Public-Subnet-1" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-public-subnet-1
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = { Name = "${var.name-prefix}-Public-Subnet1" }
}

resource "aws_subnet" "North_Virginia-Public-Subnet-2" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-public-subnet-2
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = { Name = "${var.name-prefix}-Public-Subnet2" }
}

resource "aws_subnet" "North_Virginia-Private-Subnet-1" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-private-subnet-1
  availability_zone = "us-east-1a"
  tags = { Name = "${var.name-prefix}-Private-Subnet1" }
}

resource "aws_subnet" "North_Virginia-Private-Subnet-2" {
  provider = aws.North_Virginia
  vpc_id     = aws_vpc.North_Virginia-VPC.id
  cidr_block = var.vpc-private-subnet-2
  availability_zone = "us-east-1b"
  tags = { Name = "${var.name-prefix}-Private-Subnet2" }
}

resource "aws_internet_gateway" "North_Virginia-IGW" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id
  tags = { Name = "${var.name-prefix}-IGW" }
}

resource "aws_route_table" "North_Virginia-Public-RT" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id
  tags = { Name = "${var.name-prefix}-Public-RT" }
}

resource "aws_route" "North_Virginia-Public-Route" {
  provider = aws.North_Virginia
  route_table_id            = aws_route_table.North_Virginia-Public-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.North_Virginia-IGW.id
}

resource "aws_route_table_association" "North_Virginia-RTA-Public-Subnet-1" {
  provider      = aws.North_Virginia
  subnet_id     = aws_subnet.North_Virginia-Public-Subnet-1.id
  route_table_id = aws_route_table.North_Virginia-Public-RT.id
}

resource "aws_route_table_association" "North_Virginia-RTA-Public-Subnet-2" {
  provider      = aws.North_Virginia
  subnet_id     = aws_subnet.North_Virginia-Public-Subnet-2.id
  route_table_id = aws_route_table.North_Virginia-Public-RT.id
}

//-----------------------------------------------------------
resource "aws_eip" "North_Virginia-EIP" {
  provider = aws.North_Virginia
  domain = "vpc"
}

resource "aws_nat_gateway" "North_Virginia-NAT" {
  provider = aws.North_Virginia
  allocation_id = aws_eip.North_Virginia-EIP.id
  subnet_id     = aws_subnet.North_Virginia-Public-Subnet-1.id
  tags = { Name = "${var.name-prefix}-NAT" }
}

resource "aws_route_table" "North_Virginia-Private-RT" {
  provider = aws.North_Virginia
  vpc_id = aws_vpc.North_Virginia-VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.North_Virginia-NAT.id
  }
  tags = { Name = "${var.name-prefix}-Private-RT" }
}

resource "aws_route_table_association" "North_Virginia-RTA-Private-Subnet-1" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Private-Subnet-1.id
  route_table_id = aws_route_table.North_Virginia-Private-RT.id
}

resource "aws_route_table_association" "North_Virginia-RTA-Private-Subnet-2" {
  provider = aws.North_Virginia
  subnet_id      = aws_subnet.North_Virginia-Private-Subnet-2.id
  route_table_id = aws_route_table.North_Virginia-Private-RT.id
}
