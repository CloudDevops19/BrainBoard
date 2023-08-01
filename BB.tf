resource "aws_vpc" "BB_VPC" {
  tags       = merge(var.tags, {})
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "BB_Subnet" {
  vpc_id            = aws_vpc.BB_VPC.id
  tags              = merge(var.tags, {})
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"
}

resource "aws_instance" "BB_EC2" {
  tags                        = merge(var.tags, {})
  subnet_id                   = aws_subnet.BB_Subnet.id
  instance_type               = "t2.micro"
  availability_zone           = "ap-southeast-1a"
  associate_public_ip_address = true
  ami                         = "ami-0a720e9f14071b468"

  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = "10"
    http_endpoint               = "enabled"
  }

  root_block_device {
    encrypted = true
  }
}

