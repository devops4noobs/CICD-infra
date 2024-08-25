provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_id]
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam-instance-profile.name
  count                  = var.instance_count
  user_data              = base64encode(file("${path.module}/userdata.sh"))
  //for_each               = toset(["ansible"])
  /*tags = {
    Name = "${each.key}"
  }*/
  tags = {
    Name = var.instance-name
  }

}