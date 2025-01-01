resource "random_id" "id" {
  byte_length = 2
}


resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "webserver-${random_id.id.id}"
    Env  = "Dev"
  }
  key_name   = aws_key_pair.ssh-key.id
  user_data  = file("./cockpit.sh")
  depends_on = [random_id.id]
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "shh-connection"
  public_key = file("/Your_public_key_path")
}


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id
  ingress {
    protocol    = "tcp"
    from_port   = var.from_port[0]
    to_port     = var.to_port[0]
    cidr_blocks = var.cidr_block
    description = var.rule_description[0]
  }
  ingress {
    protocol    = "tcp"
    from_port   = var.from_port[1]
    to_port     = var.to_port[1]
    cidr_blocks = var.cidr_block
    description = var.rule_description[1]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }
}
output "webserver_name" {
  value = aws_instance.webserver.tags.Name
}
output "public_dnc" {
  value = aws_instance.webserver.public_dns
}
