resource "aws_vpc" "test" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test"
  }
}

resource "aws_subnet" "test_pub_sub" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "test_pub_sub"
  }
}

resource "aws_subnet" "test_pvt_sub" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "test_pvt_sub"
  }
}
resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test_igw"
  }
}
resource "aws_route_table" "test_pub_rt" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
  tags = {
    Name = "test_pb_rt"
  }
}

resource "aws_route_table" "test_pvt_rt" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = {
    Name = "test_pvt_rt"
  }
}


resource "aws_route_table_association" "test_pub_assoc" {
  subnet_id      = aws_subnet.test_pub_sub.id
  route_table_id = aws_route_table.test_pub_rt.id
}
resource "aws_eip" "my_eip" {
  tags = {
    Name = "test_eip"
  }
}
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.test_pub_sub.id
  depends_on    = [aws_internet_gateway.test_igw]
}
output "Elastic_ip" {
  value = aws_nat_gateway.my_nat.allocation_id
}


resource "aws_route_table_association" "test_pvt_assoc" {
  subnet_id      = aws_subnet.test_pvt_sub.id
  route_table_id = aws_route_table.test_pvt_rt.id
}

