resource "aws_key_pair" "key" {
  key_name = "cr-key-terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSxgP06dbv2uOudF4tfS8rm21n1rLYgqPeLP4IXMsKk2k1Rr3qXQXpc+exturNJJxsL921K/SX1cvrx7y4M/IrH1cqvFpnjkdFUYpTkCstLSRLmMpIzAoIKOk0DfLNPNZw/DjZ8gwRy2zoIh7xrtlGqGlXKjCRUwU9lh4uLONhqK7DKdpAQcJp2ve22U5vDvI8I2n6BtyDuwa7sHCu/QZchsYUnZZTS0rrSP34lpKMCPNB70uYZjHPYFsNWQkFBE53dywM0/VhBZBn8Wgml2qaGtrJPMGMc7zozZaGcbJueVtt1QcTzqzloeg7wq+ldAVi+mSNBv/qm9AQwEees6b1 cr@cr-VirtualBox"
}

resource "aws_instance" "demo" {
    ami = "ami-083ac7c7ecf9bb9b0"
    instance_type = "t3.micro"
    subnet_id = var.vpc_subnet_id

    key_name = aws_key_pair.key.key_name

    tags = {
      Name = "demo-cr"
    }

    connection {
        type = "ssh"
        host = aws_instance.demo.public_ip
        user = "ec2-user"
        port = 22
        agent = true
    }
}