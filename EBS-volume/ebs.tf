provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ebs-instance" {
  ami           = "ami-0ec0e125bb6c6e8ec"
  key_name      =  "terrafrom-ebs"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "ebs-volume-instance"
  }

}

resource "aws_ebs_volume" "ebs_1_volume" {
  availability_zone = "ap-south-1a"
  size              = 10
  type              = "gp2"
}

resource "aws_volume_attachment" "ebs_1_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_1_volume.id
  instance_id = aws_instance.ebs-instance.id
}
