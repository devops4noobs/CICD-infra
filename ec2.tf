provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t2.micro"
  key_name               = var.key-name
  vpc_security_group_ids = [aws_security_group.security-group.id]
  subnet_id              = aws_subnet.public-subnet.id
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name

  //for_each               = toset(["ansible"])
  /*tags = {
    Name = "${each.key}"
  }*/
  tags = {
    Name = var.instance-name
  }
  
}