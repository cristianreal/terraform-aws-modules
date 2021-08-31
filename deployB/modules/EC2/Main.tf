

// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "key" {
  key_name = "cr-key-terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSxgP06dbv2uOudF4tfS8rm21n1rLYgqPeLP4IXMsKk2k1Rr3qXQXpc+exturNJJxsL921K/SX1cvrx7y4M/IrH1cqvFpnjkdFUYpTkCstLSRLmMpIzAoIKOk0DfLNPNZw/DjZ8gwRy2zoIh7xrtlGqGlXKjCRUwU9lh4uLONhqK7DKdpAQcJp2ve22U5vDvI8I2n6BtyDuwa7sHCu/QZchsYUnZZTS0rrSP34lpKMCPNB70uYZjHPYFsNWQkFBE53dywM0/VhBZBn8Wgml2qaGtrJPMGMc7zozZaGcbJueVtt1QcTzqzloeg7wq+ldAVi+mSNBv/qm9AQwEees6b1 cr@cr-VirtualBox"
}

// Configure the EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = var.vpc.public_subnets[0]

  tags = {
    "Name" = "${var.namespace}-EC2-PUBLIC"
  }
  
  connection {
      type        = "ssh"
      host        = aws_instance.ec2_public.public_ip
      user        = "ec2-user"
      port        = 22
      agent       = true
    }

}