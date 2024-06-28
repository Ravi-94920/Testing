resource "aws_s3_bucket" "main" {
  bucket = "your-bucket-name"
  acl    = "private"

  tags = {
    Name = "your-bucket-name"
  }
}