resource "aws_security_group" "public" {
  name        = "${var.env_code}-public"
  description = "Public security group"
  vpc_id      = data.terraform_remote_state.level1.outputs.vpc_id

  ingress {
    description = "SSH from my public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  ingress {
    description = "SSH from my public IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_instance" "public" {
  ami                         = data.aws_ami.amazonlinux.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  key_name                    = "pawan"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = data.terraform_remote_state.level1.outputs.public_subnet_ids

  user_data = file("user-data.sh")

  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.env_code}-private"
  description = "Private security group"
  vpc_id      = data.terraform_remote_state.level1.outputs.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.level1.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-private"
  }
}

resource "aws_instance" "private-instance" {
  ami                    = data.aws_ami.amazonlinux.id
  instance_type          = "t3.micro"
  key_name               = "pawan"
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = data.terraform_remote_state.level1.outputs.private_subnet_ids

  tags = {
    Name = "${var.env_code}-private"
  }
}
