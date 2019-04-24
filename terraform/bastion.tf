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
  public_key = ""
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
