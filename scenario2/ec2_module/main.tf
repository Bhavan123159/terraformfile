resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.keypair.key_name}"
  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  user_data = "${file("../jenkins.sh")}"
  subnet_id = "${module.module-1.mosub}"
  tags = {
    Name = "sever-for-jenkins"
  }
}
resource "aws_eip" "my-eip" {
  instance = "${aws_instance.instance.id}"
  vpc      = true
}
resource "aws_key_pair" "keypair" {
  key_name = "sen"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCetBCT+ccjUEz9pNBoC5uCJvfliS+ndCzS2WR6V/9V/glwXYC52vbMYraCGSNRF0WkkxTYZFM6/sQigrnEQaGrWjHDLKWbDt6T+il7vYZWvfg5RYO0+xfV1dUOZQrZyYrRDH3ciM+M7Ib94TRS9QO7IghuZHqfWzmkXBEh6W1loAAUugPwN9OcxJGFxpctquuEeqUpib99MG8qbRMc75WdDKbzpuPAyvhdPeO2vu+jVsKn57yTouB6heI8cTj5Yo2ow5YcULKQpX8rEOql5sJBC44CHLziSaDN3PLuKefs7KDEN6arJjRRrksftcOQ7E/8MRQli0Y3v0gm+9Cxm5xn root@text-PC"
}

resource "aws_security_group" "allow_ports" {
  name = "allow_pors"
  vpc_id = "${module.module-1.movpc}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

module "module-1" {
  source = "/home/senario1/Network"
}

~                                                                                                                                                                                                                                                                            ~        
