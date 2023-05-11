resource "aws_instance" "app_server" {
  ami           = "ami-0a72af05d27b49ccb"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
