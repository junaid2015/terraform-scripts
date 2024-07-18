resource "aws_instance" "myinstance" {
  ami               = "ami-0ad21ae1d0696ad58"
  instance_type     = var.aws_instance_type
  availability_zone = "ap-south-1a"

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_config.v_size
    volume_type           = var.ec2_config.v_type
  }

  tags = {
    Name = "sampleServer"
  }

}

