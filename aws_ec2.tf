# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-08c40ec9f2e232896"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}