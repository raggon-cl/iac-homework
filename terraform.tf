# crear VPC privada
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "vpc-rodrigo-aguilar"
  cidr = "172.16.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  public_subnets  = ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}


# NSG HTTP Inbound
resource "aws_security_group" "http_ingress" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_blocks]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.allowed_cidr_blocks]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# abrir shell script que provisiona VMs
data "template_file" "install_docker1" {
  template = file("install_docker1.sh")
}

data "template_file" "install_docker2" {
  template = file("install_docker2.sh")
}

data "template_file" "install_docker3" {
  template = file("install_docker3.sh")
}



# Create VM
resource "aws_instance" "web-server-1" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  user_data              = data.template_file.install_docker1.rendered
  vpc_security_group_ids = [aws_security_group.http_ingress.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "webserver-1",
  }
}

resource "aws_instance" "web-server-2" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  user_data              = data.template_file.install_docker2.rendered
  vpc_security_group_ids = [aws_security_group.http_ingress.id]
  subnet_id              = module.vpc.public_subnets[1]

  tags = {
    Name = "webserver-2",
  }
}

resource "aws_instance" "web-server-3" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  user_data              = data.template_file.install_docker3.rendered
  vpc_security_group_ids = [aws_security_group.http_ingress.id]
  subnet_id              = module.vpc.public_subnets[2]

  tags = {
    Name = "webserver-3",
  }
}


# obtener IPs de las maquinas creadas
output "web-server-1-ip" {
  value = aws_instance.web-server-1.public_ip
}

output "web-server-2-ip" {
  value = aws_instance.web-server-2.public_ip
}

output "web-server-3-ip" {
  value = aws_instance.web-server-3.public_ip
}

# crear Balanceador de Carga (LB)
resource "aws_elb" "web-server-lb" {
  name            = "web-server-lb"
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.http_ingress.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

# Obtain LB DNS Name
output "web-server-lb-dns" {
  value = aws_elb.web-server-lb.dns_name
}

# Attach VMs to LB
resource "aws_elb_attachment" "web-server-lb-1" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.web-server-1.id
}

resource "aws_elb_attachment" "web-server-lb-2" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.web-server-2.id
}

resource "aws_elb_attachment" "web-server-lb-3" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.web-server-3.id
}
