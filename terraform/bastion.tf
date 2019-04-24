resource "aws_instance" "bastion" {
  key_name = "${aws_key_pair.bastion_key.key_name}"
  instance_type = "t2.micro"
  ami = "ami-028d6461780695a43"
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]
  availability_zone = "us-east-1a"
  subnet_id = "${element(module.dev_vpc.public_subnets, 0)}"
  associate_public_ip_address = true
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "cluster"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCaPp98f5IPG6A4vL1D1S5cn8ovKAlXr5ckH6vnZ84WlLPyMWahNZHT50daXFpTA4KPBMbaYryE5RN3M41nYY341JtwoTjgAVs49TDMoOmYbWaGKxUSZQvsyOvqC/HL/G02mWj9IMyPMl0bj2EEVmoFLj4814SWmbg2C2heri/7CFVIRP49YNjpOj1sWg04joouG37ngusodF6BizX7UmYip9ZZ6dFtf8R7VxkglXkNhLMxqJleTe9iWTcXC/9vXRy+oyWb1BP4WArsgnhtEQx5KA41QrkasHvcv0AYu9EkQL2xQYW3mSJ5UszowpTdyAuuRfjGmMXUH51TbzquJTHcGEM6FoYqVeES1QN3KrSSEpu7gEAHIek/uYZQ1LQWb6z0L1eUgb2zyitjN3PoxZthwbVtPEfrnYBgjKYiuoSx6og42Us7ku/U4Wusx9N9/6s8Jv2CdLdFXV56fDQzZOnYsIWMm1RsM/NGOJdtm2duQ7j1vo2UCEPIvbsR32RaY7/+yBqbQ/KAjT/WU1PMUSi8Wn7l7oOx+STKpZv5lnRzEIYC7wshaJtBjlYJw9F2bHsXcPtMq64ekuYqm/tblEQCoIcTMxq4updAjDghlxAWDS4JMs8vf2nCruk0oaDJKbRedLtsGk8gX++oboUTQJfB6GuHx1I6u2smVOCJUGjEQ== zhitingz@cash"
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${module.dev_vpc.vpc_id}"
  tags   = "${merge(local.tags)}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
