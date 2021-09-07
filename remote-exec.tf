
data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "devops14-tf-key-1"
  public_key = file("${path.module}/my_pub_key.txt")
}
resource "aws_instance" "remote-ec2" {
  ami                    = data.aws_ami.amazon.id
  subnet_id = aws_subnet.my-public-subnet.id
  instance_type          = var.instance_type
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  provisioner "remote-exec" {
    inline = [
     "sudo yum install -y httpd",
      "cd /var/www/html",
      "sudo wget https://devops14-mini-project.s3.amazonaws.com/default/index-default.html",
      "sudo wget https://devops14-mini-project.s3.amazonaws.com/default/mycar.jpeg",
      "sudo mv index-default.html index.html",
      "sudo systemctl enable httpd --now"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./priv_key.pem")
      host        = self.public_ip
    }
  }
}



resource "aws_security_group" "my-sg" {
  name = "remote-ssh"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }
}

locals {
  time = formatdate("DD MM YYYY hh:mm ZZZ", timestamp())
}

output "timestamp" {
  value = local.time
  
}
