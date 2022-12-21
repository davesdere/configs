provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "guacamole_sg" {
  name        = "guacamole_sg"
  description = "Security group for Guacamole EC2 instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "guacamole_server" {
  ami           = "ami-0ac019f4fcb7cb7e6"
  instance_type = "t2.micro"
  key_name      = "my_key_pair"

  security_groups = [aws_security_group.guacamole_sg.id]

  user_data = <<EOF
#!/bin/bash

yum update -y
yum install -y httpd
yum install -y gcc libcairo2-dev libjpeg-turbo-dev libpng-dev libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev mysql-devel

wget https://downloads.apache.org/guacamole/1.3.0/source/guacamole-server-1.3.0.tar.gz
tar -xzf guacamole-server-1.3.0.tar.gz
cd guacamole-server-1.3.0/
./configure --with-init-dir=/etc/init.d
make
make install
ldconfig
systemctl enable guacd
systemctl start guacd

cat <<EOF > /etc/httpd/conf.d/guacamole.conf
<Location /guacamole>
  Order allow,deny
  Allow from all
  Require all granted
  ProxyPass http://localhost:8080/guacamole
  ProxyPassReverse http://localhost:8080/guacamole
</Location>
EOF

systemctl enable httpd
systemctl start httpd
EOF
}

resource "aws_eip" "guacamole_eip" {
  instance = aws_instance.guacamole_server.id
}
